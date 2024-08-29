//
//  ChatMenuViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import Foundation

final class ChatMenuViewModel {

    var myPercent: Int? = 50

    private(set) var progressingUsers = Observable<[GoalUserModel]>([])
    private(set) var completedUsers = Observable<[GoalUserModel]>([])

    // MARK: - Initializer

    let isbn: String

    init(isbn: String) {
        self.isbn = isbn
    }

    // MARK: - Actions

    enum Action {
        case loadChatMenu(isbn: String)
    }

    func send(action: Action) {
        switch action {
        case let .loadChatMenu(isbn):
            Task {
                do {
                    let progressingUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: false)
                    let completedUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: true)
                    let myProgress = try await GoalService.getMyProgress(of: isbn)

                    print(myProgress)

                    await MainActor.run {
                        self.progressingUsers.value = progressingUsers
                        self.completedUsers.value = completedUsers
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
