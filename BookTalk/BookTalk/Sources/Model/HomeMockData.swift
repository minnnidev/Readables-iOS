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
            books: [
                HomeBooks(title: "Book 1", author: "Author 1", coverImageURL: "https://example.com/1.png"),
                HomeBooks(title: "Book 2", author: "Author 2", coverImageURL: "https://example.com/2.png"),
                HomeBooks(title: "Book 3", author: "Author 3", coverImageURL: "https://example.com/3.png"),
                HomeBooks(title: "Book 4", author: "Author 4", coverImageURL: "https://example.com/4.png"),
                HomeBooks(title: "Book 5", author: "Author 5", coverImageURL: "https://example.com/5.png")
            ]
        ),
        HomeSection(
            header: "이번 달 20대 남성이 많이 대출한 책!",
            books: [
                HomeBooks(title: "Book 1-1", author: "Author 1-1", coverImageURL: "https://example.com/6.png"),
                HomeBooks(title: "Book 2-1", author: "Author 2-1", coverImageURL: "https://example.com/7.png"),
                HomeBooks(title: "Book 3-1", author: "Author 3-1", coverImageURL: "https://example.com/8.png"),
                HomeBooks(title: "Book 4-1", author: "Author 4-1", coverImageURL: "https://example.com/9.png"),
                HomeBooks(title: "Book 5-1", author: "Author 5-1", coverImageURL: "https://example.com/10.png")
            ]
        ),
        HomeSection(
            header: "인간관계론을 읽은 OOO님, 이 책은 어떠세요?",
            books: [
                HomeBooks(title: "Book 1-2", author: "Author 1-2", coverImageURL: "https://example.com/11.png"),
                HomeBooks(title: "Book 2-2", author: "Author 2-2", coverImageURL: "https://example.com/12.png"),
                HomeBooks(title: "Book 3-2", author: "Author 3-2", coverImageURL: "https://example.com/13.png"),
                HomeBooks(title: "Book 4-2", author: "Author 4-2", coverImageURL: "https://example.com/14.png"),
                HomeBooks(title: "Book 5-2", author: "Author 5-2", coverImageURL: "https://example.com/15.png")
            ]
        ),
        HomeSection(
            header: "OOO님 동네에서 대출이 많은 도서!",
            books: [
                HomeBooks(title: "Book 1-3", author: "Author 1-3", coverImageURL: "https://example.com/16.png"),
                HomeBooks(title: "Book 2-3", author: "Author 2-3", coverImageURL: "https://example.com/17.png"),
                HomeBooks(title: "Book 3-3", author: "Author 3-3", coverImageURL: "https://example.com/18.png"),
                HomeBooks(title: "Book 4-3", author: "Author 4-3", coverImageURL: "https://example.com/19.png"),
                HomeBooks(title: "Book 5-3", author: "Author 5-3", coverImageURL: "https://example.com/20.png")
            ]
        ),
        HomeSection(
            header: "대출 급상승 도서!",
            books: [
                HomeBooks(title: "Book 1-4", author: "Author 1-4", coverImageURL: "https://example.com/21.png"),
                HomeBooks(title: "Book 2-4", author: "Author 2-4", coverImageURL: "https://example.com/22.png"),
                HomeBooks(title: "Book 3-4", author: "Author 3-4", coverImageURL: "https://example.com/23.png"),
                HomeBooks(title: "Book 4-4", author: "Author 4-4", coverImageURL: "https://example.com/24.png"),
                HomeBooks(title: "Book 5-4", author: "Author 5-4", coverImageURL: "https://example.com/25.png")
            ]
        )
    ]
}
