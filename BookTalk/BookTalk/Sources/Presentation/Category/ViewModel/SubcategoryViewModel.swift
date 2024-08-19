//
//  SecondCategoryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import Foundation

final class SubcategoryViewModel {

    // MARK: - Actions

    enum Action {
        case setSubcategory(subcategoryIdx: Int)
        case loadBooks(subcategoryIdx: Int)
    }

    // MARK: - Properties

    var subcategory: Observable<String> = Observable("전체")
    var popularBooks = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    var newBooks = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    var isLoading = Observable(false)
    var subcategoryIdx: Int = 0 {
        didSet {
            send(action: .loadBooks(subcategoryIdx: subcategoryIdx))
        }
    }

    let firstCategoryType: CategoryType

    // MARK: - Initializer

    init(
        firstCategoryType: CategoryType
    ) {
        self.firstCategoryType = firstCategoryType
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .setSubcategory(subcategoryIndex):
            subcategoryIdx = subcategoryIndex
            subcategory.value = firstCategoryType.subcategories[subcategoryIndex]

        case let .loadBooks(subcategoryIdx):
            isLoading.value = true

            let (month, week) = Date().currentWeekOfMonth()
            let genreCode = "\(firstCategoryType.rawValue)\(subcategoryIdx)"

            Task {
                do {
                    let popularBooks = try await GenreService.getThisWeekTrend(
                        with: .init(genreCode: genreCode)
                    )
                    let newBooks = try await GenreService.getNewTrend(
                        with: .init(genreCode: genreCode)
                    )

                    await MainActor.run {
                        self.popularBooks.value.headerTitle = "\(month)월 \(week)주차 TOP 10"
                        self.popularBooks.value.books = popularBooks

                        self.newBooks.value.headerTitle = "새로 나온 책들을 확인해 보세요!"
                        self.newBooks.value.books = newBooks

                        isLoading.value = false
                    }

                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                    await MainActor.run {
                        isLoading.value = false
                    }
                }
            }
        }
    }
}
