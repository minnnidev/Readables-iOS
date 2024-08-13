//
//  AddBookViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import Foundation

final class AddBookViewModel {

    enum Action {
        case loadResult(query: String)
    }

    // MARK: - Properties

    var books = Observable<[String]>([]) // TODO: 수정
    var searchText = Observable("")

    private let bookName: String?

    // MARK: - Initializer

    init(bookName: String? = nil) {
        self.bookName = bookName

        searchText.value = bookName ?? ""
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .loadResult(query):
            // TODO: API 통신
            return
        }
    }
}
