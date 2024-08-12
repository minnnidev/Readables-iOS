//
//  HomeMockData.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import Foundation

struct HomeMockData {
    static let sections: [HomeSection] = [
        HomeSection(
            header: "현재 핫한 오픈톡",
            bookInfo: [
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
                    registeredLibraries: []
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
                    registeredLibraries: [
                        Library(
                        name: "가 도서관",
                        isAvailable: true
                        ),
                        Library(
                        name: "나 도서관",
                        isAvailable: false
                        ),
                        Library(
                        name: "다 도서관",
                        isAvailable: true
                        )
                    ]
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
                    registeredLibraries: [
                        Library(
                        name: "가 도서관",
                        isAvailable: false
                        ),
                        Library(
                        name: "나 도서관",
                        isAvailable: false
                        ),
                        Library(
                        name: "다 도서관",
                        isAvailable: false
                        )
                    ]
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
                    registeredLibraries: []
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
                    registeredLibraries: []
                )
            ]
        ),
        HomeSection(
            header: "이번 달 북토크가 추천드리는 책!",
            bookInfo: [
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/1-1.png",
                        title: "Book 1-1",
                        author: "Author 1-1"
                    ),
                    keywords: [
                        "# Keyword 1", "# Keyword 2", "# Keyword 3", "# Keyword 4", "# Keyword 5"
                    ],
                    publisher: "Publisher 1-1",
                    publicationDate: "2024-01-01",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/2-1.png",
                        title: "Book 2-1",
                        author: "Author 2-1"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2"],
                    publisher: "Publisher 2-1",
                    publicationDate: "2024-01-02",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/3-1.png",
                        title: "Book 3-1",
                        author: "Author 3-1"
                    ),
                    keywords: ["# Keyword 1"],
                    publisher: "Publisher 3-1",
                    publicationDate: "2024-01-03",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/4-1.png",
                        title: "Book 4-1",
                        author: "Author 4-1"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2" ,"# Keyword 3"],
                    publisher: "Publisher 4-1",
                    publicationDate: "2024-01-04",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/5-1.png",
                        title: "Book 5-1",
                        author: "Author 5-1"
                    ),
                    keywords: ["# Keyword 1"],
                    publisher: "Publisher 5-1",
                    publicationDate: "2024-01-05",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                )
            ]
        ),
        HomeSection(
            header: "OOO님 주변에서 대출이 많은 도서!",
            bookInfo: [
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/1-2.png",
                        title: "Book 1-2",
                        author: "Author 1-2"
                    ),
                    keywords: [],
                    publisher: "Publisher 1-2",
                    publicationDate: "2024-01-01",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/2-2.png",
                        title: "Book 2-2",
                        author: "Author 2-2"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2", "# Keyword 3"],
                    publisher: "Publisher 2-2",
                    publicationDate: "2024-01-02",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/3-2.png",
                        title: "Book 3-2",
                        author: "Author 3-2"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2"],
                    publisher: "Publisher 3-2",
                    publicationDate: "2024-01-03",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/4-2.png",
                        title: "Book 4-2",
                        author: "Author 4-2"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2", "# Keyword 3", "# Keyword 4"],
                    publisher: "Publisher 4-2",
                    publicationDate: "2024-01-04",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/5-2.png",
                        title: "Book 5-2",
                        author: "Author 5-2"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2"],
                    publisher: "Publisher 5-2",
                    publicationDate: "2024-01-05",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                )
            ]
        ),
        HomeSection(
            header: "대출 급상승 도서!",
            bookInfo: [
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/1-3.png",
                        title: "Book 1-3",
                        author: "Author 1-3"
                    ),
                    keywords: ["# Keyword 1"],
                    publisher: "Publisher 1-3",
                    publicationDate: "2024-01-01",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/2-3.png",
                        title: "Book 2-3",
                        author: "Author 2-3"
                    ),
                    keywords: ["# Keyword 1"],
                    publisher: "Publisher 2-3",
                    publicationDate: "2024-01-02",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/3-3.png",
                        title: "Book 3-3",
                        author: "Author 3-3"
                    ),
                    keywords: ["# Keyword 1"],
                    publisher: "Publisher 3-3",
                    publicationDate: "2024-01-03",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/4-3.png",
                        title: "Book 4-3",
                        author: "Author 4-3"
                    ),
                    keywords: ["# Keyword 1", "# Keyword 2", "# Keyword 3"],
                    publisher: "Publisher 4-3",
                    publicationDate: "2024-01-04",
                    isAvailable: true,
                    isFavorite: false,
                    registeredLibraries: []
                ),
                DetailBookInfo(
                    basicBookInfo: BasicBookInfo(
                        coverImageURL: "https://example.com/5-3.png",
                        title: "Book 5-3",
                        author: "Author 5-3"
                    ),
                    keywords: [],
                    publisher: "Publisher 5-3",
                    publicationDate: "2024-01-05",
                    isAvailable: false,
                    isFavorite: false,
                    registeredLibraries: []
                )
            ]
        )
    ]
}
