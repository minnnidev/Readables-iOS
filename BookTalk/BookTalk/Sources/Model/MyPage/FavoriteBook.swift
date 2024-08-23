//
//  FavoriteBook.swift
//  BookTalk
//
//  Created by RAFA on 8/23/24.
//

import Foundation

struct FavoriteBook {
    let bookName: String
    let bookAuthor: String
}

extension FavoriteBook {
    
    static let sampleData: [FavoriteBook] = [
        FavoriteBook(bookName: "Moby-Dick", bookAuthor: "Herman Melville"),
        FavoriteBook(bookName: "Pride and Prejudice", bookAuthor: "Jane Austen"),
        FavoriteBook(bookName: "War and Peace", bookAuthor: "Leo Tolstoy"),
        FavoriteBook(bookName: "The Lord of the Rings", bookAuthor: "J.R.R. Tolkien"),
        FavoriteBook(bookName: "The Hobbit", bookAuthor: "J.R.R. Tolkien"),
        FavoriteBook(bookName: "Jane Eyre", bookAuthor: "Charlotte Brontë"),
        FavoriteBook(bookName: "To Kill a Mockingbird", bookAuthor: "Harper Lee"),
        FavoriteBook(bookName: "1984", bookAuthor: "George Orwell")
    ]
}

extension FavoriteBook: BookDisplayable {
    
    var title: String {
        return self.bookName
    }
    
    var author: String {
        return self.bookAuthor
    }
    
    var imageURL: String {
        return ""
    }
}
