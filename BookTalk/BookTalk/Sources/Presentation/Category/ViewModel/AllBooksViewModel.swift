//
//  ThirdCategoryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import Foundation

final class AllBooksViewModel {

    // MARK: - Properties

    private let genreCode: String

    // MARK: - Initializer

    init(genreCode: String) {
        self.genreCode = genreCode
    }

    // MARK: - Helpers

    enum Action {
        case sort(_ sortType: BookSortType)
    }

    func send(action: Action) {
        
    }
}
