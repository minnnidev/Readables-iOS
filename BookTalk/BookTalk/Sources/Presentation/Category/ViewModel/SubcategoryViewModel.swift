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
        case setSubcategory(subcategoryName: String)
    }

    // MARK: - Properties

    let sections: [CategorySectionKind] = [.banner, .category, .allBookButton, .popularBooks, .newBooks]
    let popularBooks: BooksWithHeader = .init(headerTitle: "7월 4주차 TOP 10", books: [])
    let newBooks: BooksWithHeader = .init(headerTitle: "신작 도서", books: [])
    var subcategory = Observable("전체")

    // MARK: - Initializer

    let firstCategoryType: CategoryType

    init(firstCategoryType: CategoryType) {
        self.firstCategoryType = firstCategoryType
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .setSubcategory(subcategoryName):
            subcategory.value = subcategoryName
        }
    }
}
