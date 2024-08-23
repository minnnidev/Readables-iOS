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

struct Book {
    var isbn: String
    var imageURL: String
    var title: String
}

extension Book: BookDisplayable {
    
    var author: String {
        return ""
    }
    
    var bookTitle: String {
        return self.title
    }

    var bookImageURL: String {
        return self.imageURL
    }
}
