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

    var books = Observable<[String]>([]) // TODO: 수정
    var searchText = Observable("")

    func send(action: Action) {
        switch action {
        case let .loadResult(query):
            // TODO: API 통신
            return
        }
    }
}
