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
        let areChildButtonsVisible: Observable<Bool>
        let isFavorite: Observable<Bool>
        let isLiked: Observable<Bool>
        let isDisliked: Observable<Bool>
        let showLibraryRegistrationButton: Observable<Bool>
        let borrowableLibraries: Observable<[Library]>
    }
    
    // MARK: - Properties
    
    private let bookInfo: DetailBookInfo
    lazy var input: Input = { return bindInput() }()
    lazy var output: Output = { return transform() }()
    
    // MARK: - Initializer
    
    init(bookInfo: DetailBookInfo) {
        self.bookInfo = bookInfo
    }
    
    // MARK: - Helpers
    
    private func toggle(_ property: Observable<Bool>?, opposite: Observable<Bool>? = nil) {
        guard let property = property else { return }
        property.value.toggle()
        if let opposite = opposite, property.value { opposite.value = false }
    }
    
    private func updateAvailability(
        _ libraries: [Library],
        isRegistered: Bool
    ) -> (text: String, color: UIColor) {
        guard isRegistered else {
            return ("대출 여부를 확인하려면 도서관을 등록해주세요.", .systemGray)
        }
        
        let isAvailable = libraries.contains { $0.isAvailable }
        let text = isAvailable ? "대출 가능" : "대출 불가능"
        let color = isAvailable ? UIColor.systemGreen : .systemRed
        
        return (text, color)
    }
    
    private func bindInput() -> Input {
        return Input(
            favoriteButtonTap: { [weak self] in
                self?.toggle(self?.output.isFavorite)
            },
            likeButtonTap: { [weak self] in
                self?.toggle(self?.output.isLiked, opposite: self?.output.isDisliked)
            },
            dislikeButtonTap: { [weak self] in
                self?.toggle(self?.output.isDisliked, opposite: self?.output.isLiked)
            }
        )
    }
    
    private func transform() -> Output {
        let isLibraryRegistered = !bookInfo.registeredLibraries.isEmpty
        let availability = updateAvailability(
            bookInfo.registeredLibraries,
            isRegistered: isLibraryRegistered
        )
        
        return Output(
            coverImageURL: Observable(bookInfo.basicBookInfo.coverImageURL),
            title: Observable(bookInfo.basicBookInfo.title),
            author: Observable(bookInfo.basicBookInfo.author),
            publisher: Observable(bookInfo.publisher),
            publicationDate: Observable(bookInfo.publicationDate),
            availabilityText: Observable(availability.text),
            availabilityTextColor: Observable(availability.color),
            areChildButtonsVisible: Observable(false),
            isFavorite: Observable(false),
            isLiked: Observable(false),
            isDisliked: Observable(false),
            showLibraryRegistrationButton: Observable(!isLibraryRegistered),
            borrowableLibraries: Observable(bookInfo.registeredLibraries)
        )
    }
}
