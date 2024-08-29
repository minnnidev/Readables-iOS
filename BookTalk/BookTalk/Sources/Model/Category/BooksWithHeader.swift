//
//  CategoryBooks.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import Foundation

struct BooksWithHeader {
    var headerTitle: String
    var books: [Book]
}

struct GoalsWithHeader {
    var headerTitle: String
    var books: [GoalDetailModel]
}

struct Book {
    var isbn: String
    var imageURL: String
    var title: String
}
