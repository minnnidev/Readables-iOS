//
//  SearchViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import Foundation

final class SearchViewModel {
    
    private(set) var allBooks: [DetailBookInfo] = [] {
        didSet {
            
        }
    }
    
    private(set) var filteredBooks: [DetailBookInfo] = [] {
        didSet {
            onBooksUpdated?()
        }
    }
    
    var onBooksUpdated: (() -> Void)?
    
    init() {
        loadBooks()
    }
    
    func filterBooks(searchText: String) {
        if searchText.isEmpty {
            filteredBooks = []
        } else {
            filteredBooks = allBooks.filter {
                $0.basicBookInfo.title.lowercased().contains(searchText.lowercased()) ||
                $0.basicBookInfo.author.lowercased().contains(searchText.lowercased())
            }
        }
        onBooksUpdated?()
    }
    
    private func loadBooks() {
        allBooks = SearchMockData.books
    }
}
