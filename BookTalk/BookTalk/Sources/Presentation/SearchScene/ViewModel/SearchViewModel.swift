//
//  SearchViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import UIKit

final class SearchViewModel {
    
    private(set) var allBooks: [SearchBook] = [] {
        didSet {
            filteredBooks = allBooks
        }
    }
    
    private(set) var filteredBooks: [SearchBook] = [] {
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
            filteredBooks = allBooks
        } else {
            filteredBooks = allBooks.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.author.lowercased().contains(searchText.lowercased())
            }
        }
        onBooksUpdated?()
    }
    
    private func loadBooks() {
        allBooks = SearchMockData.books.map {
            SearchBook(
                coverImageURL: $0.coverImageURL,
                title: $0.title,
                author: $0.author,
                publisher: $0.publisher,
                publicationDate: $0.publicationDate,
                availability: $0.availability,
                isFavorite: $0.isFavorite,
                isBookmarked: $0.isBookmarked
            )
        }
    }
}
