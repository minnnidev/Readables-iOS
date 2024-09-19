//
//  SearchViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import UIKit

final class SearchViewModel {

    // MARK: - Interactions

    struct Input {
        let deleteSearchHistory: (String) -> Void
        let clearSearchHistory: () -> Void
        let searchWithKeyword: (String?) -> Void
        let searchButtonTapped: (String) -> Void
        let keywordButtonTapped: (Bool) -> Void
        let loadMoreResults: () -> Void
    }

    struct Output {
        let searchResult: Observable<[DetailBookInfo]>
        let searchHistory: Observable<[String]>
        let isKeywordSearch: Observable<Bool>
        let loadingState: Observable<LoadState>
        let keywordSearchText: Observable<String>
        let placeholderText: Observable<String>
    }

    // MARK: - Properties

    private let isKeywordSearchRelay = Observable<Bool>(false)
    private let loadingState = Observable<LoadState>(.initial)
    private let placeholderText = Observable<String>("")
    private let searchTextOb = Observable<String>("")
    private let searchHistoryOb = Observable<[String]>([])

    private var searchResult = Observable<[DetailBookInfo]>([])
    private let userDefaults = UserDefaults.standard
    private let searchHistoryKey = UserDefaults.Key.searchHistory
    private var currentPage = 1
    private var pageSize = 30
    private var hasMoreResult = true

    lazy var input: Input = { bindInput() }()
    lazy var output: Output = { bindOutput() }()

    // MARK: - Initializer

    var searchText: String?

    init(searchText: String? = nil) {
        self.searchText = searchText

        if searchText != nil { input.keywordButtonTapped(true) }
    }

    // MARK: - Helpers

    func saveSearchHistory(_ text: String) {
        var currentHistory = userDefaults.stringArray(forKey: searchHistoryKey) ?? []
        currentHistory.removeAll { $0 == text }
        currentHistory.insert(text, at: 0)

        userDefaults.set(currentHistory, forKey: searchHistoryKey)
        searchHistoryOb.value = currentHistory
    }

    func loadSearchHistory() {
        let history = userDefaults.stringArray(forKey: searchHistoryKey) ?? []
        searchHistoryOb.value = history
    }

    func deleteSearchHistoryItem(_ term: String) {
        var currentHistory = userDefaults.stringArray(forKey: searchHistoryKey) ?? []
        currentHistory.removeAll { $0 == term }
        userDefaults.set(currentHistory, forKey: searchHistoryKey)
        searchHistoryOb.value = currentHistory
    }

    func clearSearchHistory() {
        userDefaults.removeObject(forKey: searchHistoryKey)
        searchHistoryOb.value.removeAll()
    }

    func loadResults(of searchText: String, page: Int = 1) {
        guard hasMoreResult else { return }

        if page == 1 { loadingState.value = .loading }

        Task {
            do {
                let searchResult = try await SearchService.getSearchResult(
                    with: .init(
                        isKeyword: isKeywordSearchRelay.value,
                        input: searchText,
                        pageNo: currentPage,
                        pageSize: pageSize
                    )
                )

                await MainActor.run {
                    if page == 1 {
                        self.searchResult.value = searchResult
                    } else {
                        self.searchResult.value.append(contentsOf: searchResult)
                    }

                    loadingState.value = .completed
                    if searchResult.isEmpty { hasMoreResult = false }
                }

                saveSearchHistory(searchText)

            } catch let error as NetworkError {
                print(error.localizedDescription)
                loadingState.value = .completed
            }
        }
    }

    private func loadResultFirstTime(of searchText: String) {
        guard !searchText.isEmpty else { return }
        
        hasMoreResult = true
        searchResult.value.removeAll()
        currentPage = 1

        loadResults(of: searchText)
    }

    private func bindInput() -> Input {
        let searchWithKeyword: (String?) -> Void = { [weak self] searchText in
            guard let self = self else { return }

            if searchText != nil {
                self.searchTextOb.value = searchText ?? ""

                loadResultFirstTime(of: searchTextOb.value)
            }
        }

        let searchButtonTapped: (String) -> Void = { [weak self] searchText in
            guard let self = self else { return }

            guard !searchText.isEmpty else { return }

            searchTextOb.value = searchText
            loadResultFirstTime(of: searchText)
        }

        let keywordButtonTapped: (Bool) -> Void = { [weak self] isKeyword in
            guard let self = self else { return }

            searchResult.value.removeAll()
            hasMoreResult = true
            isKeywordSearchRelay.value = isKeyword

            placeholderText.value = isKeyword ?
                "키워드를 입력해주세요." : "책 이름 또는 작가 이름을 입력해주세요."

            guard !searchTextOb.value.isEmpty else { return }

            loadResultFirstTime(of: searchTextOb.value)
        }

        let loadMoreResults: () -> Void = { [weak self] in
            guard let self = self else { return }

            currentPage += 1
            loadResults(of: searchTextOb.value, page: currentPage)
        }


        let deleteSearchHistoryItem: (String) -> Void = { [weak self] term in
            self?.deleteSearchHistoryItem(term)
        }

        let clearSearchHistory: () -> Void = { [weak self] in
            self?.clearSearchHistory()
        }

        return Input(
            deleteSearchHistory: deleteSearchHistoryItem,
            clearSearchHistory: clearSearchHistory,
            searchWithKeyword: searchWithKeyword,
            searchButtonTapped: searchButtonTapped,
            keywordButtonTapped: keywordButtonTapped,
            loadMoreResults: loadMoreResults
        )
    }

    private func bindOutput() -> Output {
        return Output(
            searchResult: searchResult,
            searchHistory: searchHistoryOb,
            isKeywordSearch: isKeywordSearchRelay,
            loadingState: loadingState,
            keywordSearchText: searchTextOb, 
            placeholderText: placeholderText
        )
    }
}
