//
//  SearchMockData.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import Foundation

struct SearchMockData {
    static let books: [SearchBook] = [
        SearchBook(
            coverImageURL: "https://example.com/1.png",
            title: "Book 1",
            author: "Author 1",
            publisher: "Publisher 1",
            publicationDate: "2024-01-01",
            availability: true,
            isFavorite: false,
            isBookmarked: false
        ),
        SearchBook(
            coverImageURL: "https://example.com/2.png",
            title: "Book 2",
            author: "Author 2",
            publisher: "Publisher 2",
            publicationDate: "2024-01-02",
            availability: false,
            isFavorite: false,
            isBookmarked: false
        ),
        SearchBook(
            coverImageURL: "https://example.com/3.png",
            title: "Book 3",
            author: "Author 3",
            publisher: "Publisher 3",
            publicationDate: "2024-01-03",
            availability: true,
            isFavorite: false,
            isBookmarked: false
        ),
        SearchBook(
            coverImageURL: "https://example.com/4.png",
            title: "Book 4",
            author: "Author 4",
            publisher: "Publisher 4",
            publicationDate: "2024-01-04",
            availability: true,
            isFavorite: false,
            isBookmarked: false
        ),
        SearchBook(
            coverImageURL: "https://example.com/5.png",
            title: "Book 5",
            author: "Author 5",
            publisher: "Publisher 5",
            publicationDate: "2024-01-05",
            availability: false,
            isFavorite: false,
            isBookmarked: false
        )
    ]
}
