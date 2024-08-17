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
        case loadSubcategoryPopularBooks(subcategoryIdx: Int)
        case loadSubcategoryNewBooks(subcategoryIdx: Int)
    }

    // MARK: - Properties

    var subcategory: Observable<String> = Observable("전체")
    var popularBooks = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))
    var newBooks = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))

    private var subcategoryIdx: Int = 0 {
        didSet {
            send(action: .loadSubcategoryPopularBooks(subcategoryIdx: subcategoryIdx))
            send(action: .loadSubcategoryNewBooks(subcategoryIdx: subcategoryIdx))
        }
    }

    // MARK: - Initializer

    let firstCategoryType: CategoryType

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

        case let .loadSubcategoryPopularBooks(subcategoryIdx):
            let (month, week) = Date().currentWeekOfMonth()
            popularBooks.value.headerTitle = "\(month)월 \(week)주차 TOP 10"

            let genreCode = getGenreCode(
                firstCategoryType.rawValue, subcategoryIdx
            )

            Task {
                do {
                    let popularBooks = try await GenreService.getThisWeekTrend(
                        with: .init(genreCode: genreCode)
                    )

                    await MainActor.run {
                        self.popularBooks.value.books = popularBooks
                    }

                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }

        case let .loadSubcategoryNewBooks(subcategoryIdx):
            newBooks.value.headerTitle = "새로 나온 책들을 확인해 보세요!"
            return
        }
    }

    private func getGenreCode(_ firstCategoryCode: Int, _ subcategoryIndex: Int) -> String {
        return "\(firstCategoryCode)\(subcategoryIndex)"
    }
}
