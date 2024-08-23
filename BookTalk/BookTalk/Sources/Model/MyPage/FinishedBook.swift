//
//  FinishedBook.swift
//  BookTalk
//
//  Created by RAFA on 8/23/24.
//

import Foundation

struct FinishedBook {
    let bookName: String
    let bookAuthor: String
}

extension FinishedBook {
    
    static let sampleData: [FinishedBook] = [
        FinishedBook(bookName: "To Kill a Mockingbird", bookAuthor: "Harper Lee"),
        FinishedBook(bookName: "1984", bookAuthor: "George Orwell"),
        FinishedBook(bookName: "The Great Gatsby", bookAuthor: "F. Scott Fitzgerald"),
        FinishedBook(bookName: "The Catcher in the Rye", bookAuthor: "J.D. Salinger"),
        FinishedBook(bookName: "Moby-Dick", bookAuthor: "Herman Melville"),
        FinishedBook(bookName: "Pride and Prejudice", bookAuthor: "Jane Austen"),
        FinishedBook(bookName: "War and Peace", bookAuthor: "Leo Tolstoy"),
        FinishedBook(bookName: "The Lord of the Rings", bookAuthor: "J.R.R. Tolkien"),
        FinishedBook(bookName: "The Hobbit", bookAuthor: "J.R.R. Tolkien"),
        FinishedBook(bookName: "Jane Eyre", bookAuthor: "Charlotte Brontë")
    ]
}
