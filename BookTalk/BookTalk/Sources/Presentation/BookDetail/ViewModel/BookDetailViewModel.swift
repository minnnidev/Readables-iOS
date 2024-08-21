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
        let loadDetailInfo: () -> Void
    }
    
    struct Output {
        let detailBook: Observable<DetailBookInfo?>
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
    
    private let isbn: String
    private let bookDetailOb: Observable<DetailBookInfo?> = Observable(nil)

    lazy var input: Input = { return bindInput() }()
    lazy var output: Output = { return bindOutput() }()

    // MARK: - Initializer
    
    init(isbn: String) {
        self.isbn = isbn
    }
    
    // MARK: - Helpers
    
    private func toggle(_ property: Observable<Bool>?, opposite: Observable<Bool>? = nil) {
        guard let property = property else { return }
        property.value.toggle()
        if let opposite = opposite, property.value { opposite.value = false }
    }
    
    private func updateAvailability(
        _ libraries: [Library]?
    ) -> (text: String, color: UIColor) {
        guard let libraries = libraries else {
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
            },
            loadDetailInfo: {
                Task { [weak self] in
                    guard let self = self else { return }

                    do {
                        let bookDetail = try await BookService.getBookDetail(of: isbn)

                        await MainActor.run {
                            self.bookDetailOb.value = bookDetail
                        }

                    } catch let error as NetworkError {
                        print(error.localizedDescription)
                    }
                }
            }
        )
    }
    
    private func bindOutput() -> Output {
        let isRegistered = bookDetailOb.value?.registeredLibraries != nil
        let availability = updateAvailability(bookDetailOb.value?.registeredLibraries)

        return Output(
            detailBook: bookDetailOb,
            availabilityText: Observable(availability.text),
            availabilityTextColor: Observable(availability.color),
            areChildButtonsVisible:  Observable(false),
            isFavorite: Observable(false),
            isLiked: Observable(false),
            isDisliked: Observable(false),
            showLibraryRegistrationButton: Observable(isRegistered),
            borrowableLibraries: Observable(bookDetailOb.value?.registeredLibraries ?? [])
        )
    }
}
