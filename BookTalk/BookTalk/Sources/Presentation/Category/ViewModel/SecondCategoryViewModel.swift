//
//  SecondCategoryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import Foundation

final class SecondCategoryViewModel {

    enum Action {
        case setSubcategory(subcategory: String)
    }

    let sections: [CategorySectionKind] = [.banner, .category, .allBookButton, .popularBooks, .newBooks]
    let popularBooks: CategoryBooks = .init(headerTitle: "7월 4주차 TOP 10", books: [])
    let newBooks: CategoryBooks = .init(headerTitle: "신작 도서", books: [])
    var secondCategory = Observable("전체")

    let firstCategoryType: CategoryType

    init(firstCategoryType: CategoryType) {
        self.firstCategoryType = firstCategoryType
    }

    func send(action: Action) {
        switch action {
        case let .setSubcategory(subcategory):
            secondCategory.value = subcategory
        }
    }
}
