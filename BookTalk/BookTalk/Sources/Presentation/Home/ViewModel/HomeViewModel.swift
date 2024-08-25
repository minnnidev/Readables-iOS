//
//  HomeViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class HomeViewModel {

    private(set) var isKeywordOpened = Observable(false)
    private(set) var keywordOb = Observable<[Keyword]>([])

    enum Action {
        case setKeywordExpandState(newState: Bool)
        case loadKeyword
    }

    func send(action: Action) {
        switch action {
        case let .setKeywordExpandState(newState):
            isKeywordOpened.value = newState

        case .loadKeyword:
            Task {
                do {
                    let result = try await BookService.getKeywords()

                    await MainActor.run {
                        keywordOb.value = result
                    }

                } catch let error as NetworkError {
                    print(error)
                }
            }
        }
    }
}
