//
//  BookDetailViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/5/24.
//

import UIKit

final class BookDetailViewModel {
    
    // MARK: - Interactions
    
    struct Input {
        let favoriteButtonTap: () -> Void
        let likeButtonTap: () -> Void
        let dislikeButtonTap: () -> Void
    }
    
    struct Output {
        let coverImageURL: Observable<String>
        let title: Observable<String>
        let author: Observable<String>
        let publisher: Observable<String>
        let publicationDate: Observable<String>
        let availabilityText: Observable<String>
        let availabilityTextColor: Observable<UIColor>
        let distanceText: Observable<String>
        let areChildButtonsVisible: Observable<Bool>
        let isFavorite: Observable<Bool>
        let isLiked: Observable<Bool>
        let isDisliked: Observable<Bool>
    }
    
    // MARK: - Properties
    
    private let bookInfo: DetailBookInfo
    lazy var input: Input = { return bindInput() }()
    lazy var output: Output = { return transform() }()
    
    // MARK: - Initializer
    
    init(bookInfo: DetailBookInfo) {
        self.bookInfo = bookInfo
    }
    
    // MARK: - Actions
    
    private func toggleFavorite() {
        toggle(output.isFavorite)
    }
    
    private func toggleLike() {
        toggle(output.isLiked, opposite: output.isDisliked)
    }
    
    private func toggleDislike() {
        toggle(output.isDisliked, opposite: output.isLiked)
    }
    
    // MARK: - Helpers
    
    private func toggle(_ property: Observable<Bool>, opposite: Observable<Bool>? = nil) {
        property.value.toggle()
        if let opposite = opposite, property.value { opposite.value = false }
    }
    
    private func bindInput() -> Input {
        return Input(
            favoriteButtonTap: { [weak self] in
                guard let self = self else { return }
                self.toggleFavorite()
            },
            likeButtonTap: { [weak self] in
                guard let self = self else { return }
                self.toggleLike()
            },
            dislikeButtonTap: { [weak self] in
                guard let self = self else { return }
                self.toggleDislike()
            }
        )
    }
    
    private func transform() -> Output {
        return Output(
            coverImageURL: Observable(bookInfo.basicBookInfo.coverImageURL),
            title: Observable(bookInfo.basicBookInfo.title),
            author: Observable(bookInfo.basicBookInfo.author),
            publisher: Observable(bookInfo.publisher),
            publicationDate: Observable(bookInfo.publicationDate),
            availabilityText: Observable(bookInfo.isAvailable ? "대출 가능" : "대출 불가능"),
            availabilityTextColor: Observable(bookInfo.isAvailable ? .systemGreen : .systemRed),
            distanceText: Observable("\(bookInfo.distance ?? 0.0)m"),
            areChildButtonsVisible: Observable(false),
            isFavorite: Observable(false),
            isLiked: Observable(false),
            isDisliked: Observable(false)
        )
    }
}
