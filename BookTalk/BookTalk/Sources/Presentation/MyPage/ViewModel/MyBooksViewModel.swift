//
//  MyBooksViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/23/24.
//

import Foundation

final class MyBooksViewModel {
    
    // MARK: - Properties
    
    let finishedBooks: Observable<[FinishedBook]> = Observable([])
    let favoriteBooks: Observable<[FavoriteBook]> = Observable([])
    
    // MARK: - Initializer
    
    init() {
        fetchMyBooks()
    }
    
    // MARK: - Helpers
    
    private func fetchMyBooks() {
        finishedBooks.value = FinishedBook.sampleData
        favoriteBooks.value = FavoriteBook.sampleData
    }
}
