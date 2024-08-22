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
        let searchButtonTapped: (String) -> Void
        let keywordButtonTapped: (Bool) -> Void
        let loadMoreResults: () -> Void
    }

    struct Output {
        let searchResult: Observable<[DetailBookInfo]>
        let isKeywordSearch: Observable<Bool>
        let loadingState: Observable<LoadState>
    }

    // MARK: - Properties

    private let isKeywordSearchRelay = Observable<Bool>(false)
    private let loadingState = Observable<LoadState>(.initial)

    private var searchResult = Observable<[DetailBookInfo]>([])
    private var currentPage = 1
    private var pageSize = 30
    private var searchText = ""
    private var hasMoreResult = true

    lazy var input: Input = { bindInput() }()
    lazy var output: Output = { bindOutput() }()

    // MARK: - Helpers

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

            } catch let error as NetworkError {
                print(error.localizedDescription)
                loadingState.value = .completed
            }
        }
    }

    private func loadResultFirstTime(of searchText: String) {
        searchResult.value.removeAll()
        currentPage = 1

        loadResults(of: searchText)
    }

    private func bindInput() -> Input {
        let searchButtonTapped: (String) -> Void = { [weak self] searchText in
            guard let self = self else { return }

            self.searchText = searchText
            loadResultFirstTime(of: searchText)
        }

        let keywordButtonTapped: (Bool) -> Void = { [weak self] isKeyword in
            guard let self = self else { return }

            isKeywordSearchRelay.value = isKeyword
            loadResultFirstTime(of: searchText)
        }

        let loadMoreResults: () -> Void = { [weak self] in
            guard let self = self else { return }

            currentPage += 1
            loadResults(of: searchText, page: currentPage)
        }

        return Input(
            searchButtonTapped: searchButtonTapped,
            keywordButtonTapped: keywordButtonTapped,
            loadMoreResults: loadMoreResults
        )
    }

    private func bindOutput() -> Output {
        return Output(
            searchResult: searchResult,
            isKeywordSearch: isKeywordSearchRelay,
            loadingState: loadingState
        )
    }
}
