//
//  ChatMenuViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import Foundation

final class ChatMenuViewModel {

    var myPercent: Int? = nil

    enum Action {
        case loadUserStates(isbn: String)
    }

    func send(action: Action) {
        switch action {
        case let .loadUserStates(isbn):
            Task {
                do {
                    let progressUsers = try await GoalService.getUserGoal(isFinished: false)
                    let completedUsers = try await GoalService.getUserGoal(isFinished: true)

                    print(progressUsers)
                    print(completedUsers)
                    
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
