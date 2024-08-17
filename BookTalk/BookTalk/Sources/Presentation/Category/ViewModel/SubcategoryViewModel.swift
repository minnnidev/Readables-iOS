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
    }

    // MARK: - Properties

    let sections: [CategorySectionKind] = [.banner, .category, .allBookButton, .popularBooks, .newBooks]
    let popularBooks: BooksWithHeader = .init(headerTitle: "7월 4주차 TOP 10", books: [])
    let newBooks: BooksWithHeader = .init(headerTitle: "신작 도서", books: [])
    var subcategory = Observable("전체")

    // MARK: - Initializer

    let firstCategoryType: CategoryType

    init(
        firstCategoryType: CategoryType
    ) {
        self.firstCategoryType = firstCategoryType

        loadPopularBooks()
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .setSubcategory(subcategoryIndex):
            subcategory.value = firstCategoryType.subcategories[subcategoryIndex]
        }
    }

    // TODO: 수정
    func loadPopularBooks() {
        Task {
            do {
                let books = try await GenreService.getThisWeekTrend(
                    with: .init(genreCode: "13", pageNo: "1", pageSize: "10")
                )

            } catch let error as NetworkError {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    private func getGenreCode(_ firstCategoryCode: Int, _ subcategoryIndex: Int) -> String {
        return "\(firstCategoryCode)\(subcategoryIndex)"
    }
}
