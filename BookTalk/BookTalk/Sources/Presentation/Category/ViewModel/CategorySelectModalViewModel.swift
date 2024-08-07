//
//  CategorySelectModalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/7/24.
//

import Foundation

final class CategorySelectModalViewModel {

    // MARK: - Actions

    enum Action {
        case subcategorySelected(subcategory: String)
    }

    // MARK: - Properties

    let firstCategory: CategoryType
    var selectedSubcategory: String?
    var subcategoryIndex: Int?

    // MARK: - Initializer

    init(
        firstCategory: CategoryType,
        subcategory: String? = nil
    ) {
        self.firstCategory = firstCategory
        self.selectedSubcategory = subcategory
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .subcategorySelected(subcategory):
            self.selectedSubcategory = subcategory
            subcategoryIndex = findsubcategoryIndex(of: subcategory)
        }
    }

    private func findsubcategoryIndex(of subcategory: String) -> Int? {
        guard let index = firstCategory.subcategories.firstIndex(of: subcategory) else {
            return nil
        }
        
        return index
    }
}
