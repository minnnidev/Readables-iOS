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
        case loadPopularBooks(subcategoryIdx: Int)
    }

    // MARK: - Properties

    let newBooks: BooksWithHeader = .init(headerTitle: "신작 도서", books: [])
    var subcategory: Observable<String> = Observable("전체")
    var popularBooks = Observable<BooksWithHeader>(.init(headerTitle: "", books: []))

    private var subcategoryIdx: Int = 0 {
        didSet {
            send(action: .loadPopularBooks(subcategoryIdx: subcategoryIdx))
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

        case let .loadPopularBooks(subcategoryIdx):
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
        }
    }

    private func getGenreCode(_ firstCategoryCode: Int, _ subcategoryIndex: Int) -> String {
        return "\(firstCategoryCode)\(subcategoryIndex)"
    }
}
