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
        case loadUserStates(isbn: String)
    }

    func send(action: Action) {
        switch action {
        case let .loadUserStates(isbn):
            Task {
                do {
                    // TODO: 더미데이터 삭제
                    self.progressingUsers.value = [.goalUserStub1, .goalUserStub2]
                    self.completedUsers.value = [.goalUserStub1, .goalUserStub2]


//                    let progressingUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: false)
//                    let completedUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: true)
//
//                    await MainActor.run {
//                        self.progressingUsers.value = progressingUsers
//                        self.completedUsers.value = completedUsers
//                    }

                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
