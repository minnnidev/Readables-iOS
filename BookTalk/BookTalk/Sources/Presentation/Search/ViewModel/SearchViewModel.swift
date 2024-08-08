//
//  SearchViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Properties
    
    private(set) var allBooks: [DetailBookInfo] = []
    private let filteredBooksRelay = Observable<[DetailBookInfo]>([])
    var filteredBooks: [DetailBookInfo] { return filteredBooksRelay.value }
    var filteredBooksObservable: Observable<[DetailBookInfo]> { return filteredBooksRelay }
    
    // MARK: - Initializer
    
    init() {
        loadBooks()
    }
    
    // MARK: - Helpers
    
    func filterBooks(searchText: String) {
        if searchText.isEmpty {
            filteredBooksRelay.value = []
        } else {
            filteredBooksRelay.value = allBooks.filter {
                $0.basicBookInfo.title.lowercased().contains(searchText.lowercased()) ||
                $0.basicBookInfo.author.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private func loadBooks() {
        allBooks = SearchMockData.books
    }
}
