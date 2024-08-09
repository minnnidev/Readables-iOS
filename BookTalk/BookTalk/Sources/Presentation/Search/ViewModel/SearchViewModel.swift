//
//  SearchViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Interactions
    
    struct Input {
        let searchTextChanged: (String) -> Void
        let updateSearchMode: (Bool) -> Void
        let loadBooks: () -> Void
    }
    
    struct Output {
        let filteredBooks: Observable<[DetailBookInfo]>
        let isKeywordSearch: Observable<Bool>
    }
    
    // MARK: - Properties
    
    private(set) var allBooks: [DetailBookInfo] = []
    private let filteredBooksRelay = Observable<[DetailBookInfo]>([])
    private let isKeywordSearchRelay = Observable<Bool>(false)
    
    lazy var input: Input = {
        return bindInput()
    }()
    
    lazy var output: Output = {
        return transform()
    }()
    
    // MARK: - Initializer
    
    init() {
        loadBooks()
    }
    
    // MARK: - Helpers
    
    private func filterBooks(searchText: String) {
        let trimmedSearchText = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased().replacingOccurrences(of: " ", with: "")
        
        if trimmedSearchText.isEmpty {
            filteredBooksRelay.value = []
        } else {
            if isKeywordSearchRelay.value {
                filteredBooksRelay.value = allBooks.filter {
                    $0.keywords.contains {
                        $0.lowercased()
                            .replacingOccurrences(of: " ", with: "")
                            .contains(trimmedSearchText)
                    }
                }
            } else {
                filteredBooksRelay.value = allBooks.filter {
                    $0.basicBookInfo.title
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "").contains(trimmedSearchText) ||
                    $0.basicBookInfo.author
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "").contains(trimmedSearchText)
                }
            }
        }
    }
    
    private func loadBooks() {
        allBooks = SearchMockData.books
    }
    
    private func bindInput() -> Input {
        return Input(
            searchTextChanged: { [weak self] searchText in
                self?.filterBooks(searchText: searchText)
            },
            updateSearchMode: { [weak self] isKeywordSearch in
                self?.isKeywordSearchRelay.value = isKeywordSearch
            },
            loadBooks: { [weak self] in
                self?.loadBooks()
            }
        )
    }
    
    private func transform() -> Output {
        return Output(
            filteredBooks: filteredBooksRelay,
            isKeywordSearch: isKeywordSearchRelay
        )
    }
}
