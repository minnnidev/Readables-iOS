//
//  SearchMockData.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import Foundation

struct SearchMockData {
    static let books: [DetailBookInfo] = [
        DetailBookInfo(
            basicBookInfo: BasicBookInfo(
                coverImageURL: "https://example.com/1.png",
                title: "Book 1",
                author: "Author 1"
            ),
            keywords: [],
            publisher: "Publisher 1",
            publicationDate: "2024-01-01",
            isAvailable: true,
            isFavorite: false,
            distance: nil
        ),
        DetailBookInfo(
            basicBookInfo: BasicBookInfo(
                coverImageURL: "https://example.com/2.png",
                title: "Book 2",
                author: "Author 2"
            ),
            keywords: ["# Keyword 1"],
            publisher: "Publisher 2",
            publicationDate: "2024-01-02",
            isAvailable: false,
            isFavorite: false,
            distance: nil
        ),
        DetailBookInfo(
            basicBookInfo: BasicBookInfo(
                coverImageURL: "https://example.com/3.png",
                title: "Book 3",
                author: "Author 3"
            ),
            keywords: ["# Keyword 1", "# Keyword 2"],
            publisher: "Publisher 3",
            publicationDate: "2024-01-03",
            isAvailable: true,
            isFavorite: false,
            distance: nil
        ),
        DetailBookInfo(
            basicBookInfo: BasicBookInfo(
                coverImageURL: "https://example.com/4.png",
                title: "Book 4",
                author: "Author 4"
            ),
            keywords: ["# Keyword 1", "# Keyword 2", "# Keyword 3"],
            publisher: "Publisher 4",
            publicationDate: "2024-01-04",
            isAvailable: true,
            isFavorite: false,
            distance: nil
        ),
        DetailBookInfo(
            basicBookInfo: BasicBookInfo(
                coverImageURL: "https://example.com/5.png",
                title: "Book 5",
                author: "Author 5"
            ),
            keywords: ["# Keyword 1", "# Keyword 2", "# Keyword 3", "# Keyword 4"],
            publisher: "Publisher 5",
            publicationDate: "2024-01-05",
            isAvailable: false,
            isFavorite: false,
            distance: nil
        )
    ]
}
