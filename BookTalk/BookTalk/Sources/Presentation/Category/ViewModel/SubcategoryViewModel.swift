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
        case setSubcategory(subcategoryIndex: Int)
        case loadSubcategoryBooks(subcategoryIdx: Int)
    }

    // MARK: - Properties

    let sections: [CategorySectionKind] = [.banner, .category, .allBookButton, .popularBooks, .newBooks]
    let popularBooks: BooksWithHeader = .init(headerTitle: "7월 4주차 TOP 10", books: [])
    let newBooks: BooksWithHeader = .init(headerTitle: "신작 도서", books: [])
    var subcategory: Observable<String> = Observable("전체")

    private var subcategoryIdx: Int = 0 {
        didSet {
            send(action: .loadSubcategoryBooks(subcategoryIdx: subcategoryIdx))
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

        case let .loadSubcategoryBooks(subcategoryIdx):
            let genreCode = getGenreCode(
                firstCategoryType.rawValue, subcategoryIdx
            )

            Task {
                do {
                    let books = try await GenreService.getThisWeekTrend(
                        with: .init(genreCode: genreCode, pageNo: "1", pageSize: "10")
                    )

                    print(books)

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
