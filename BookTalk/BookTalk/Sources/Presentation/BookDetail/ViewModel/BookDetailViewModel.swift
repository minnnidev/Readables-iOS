//
//  BookDetailViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/2/24.
//

import UIKit

final class BookDetailViewModel {
    
    private let bookInfo: DetailBookInfo
    
    var coverImageURL: String {
        return bookInfo.basicBookInfo.coverImageURL
    }
    
    var title: String {
        return bookInfo.basicBookInfo.title
    }
        
    var author: String {
        return bookInfo.basicBookInfo.author
    }
    
    var publisher: String {
        return bookInfo.publisher
    }
    
    var publicationDate: String {
        return bookInfo.publicationDate
    }
    
    var availabilityText: String {
        return bookInfo.isAvailable ? "대출 가능" : "대출 불가능"
    }
    
    var availabilityTextColor: UIColor {
        return bookInfo.isAvailable ? .systemGreen : .systemRed
    }
    
    var distanceText: String {
        return "\(bookInfo.distance ?? 0.0)미터"
    }
    
    var isLiked: Bool = false
    var isDisliked: Bool = false
    var isBookmarked: Bool = false
    var onFloatingButtonTapped: (() -> Void)?
    var onLikeButtonTapped: (() -> Void)?
    var onDislikeButtonTapped: (() -> Void)?
    var onBookmarkButtonTapped: (() -> Void)?
    var areChildButtonsVisible: Bool = false
    
    init(bookInfo: DetailBookInfo) {
        self.bookInfo = bookInfo
    }
    
    func toggleFloatingButton() {
        areChildButtonsVisible.toggle()
        onFloatingButtonTapped?()
    }
    
    func likeButtonDidTap() {
        isLiked.toggle()
        if isLiked { isDisliked = false }
        onLikeButtonTapped?()
    }
    
    func dislikeButtonDidTap() {
        isDisliked.toggle()
        if isDisliked { isLiked = false }
        onDislikeButtonTapped?()
    }
    
    func bookmarkButtonDidTap() {
        isBookmarked.toggle()
        onBookmarkButtonTapped?()
    }
}
