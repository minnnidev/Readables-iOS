//
//  FinishedGoalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/30/24.
//

import Foundation

final class FinishedGoalViewModel {
    
    private(set) var goalDetail = Observable<GoalDetailModel?>(nil)
    private(set) var deleteSucceed = Observable(false)
    private(set) var loadState = Observable(LoadState.initial)

    let goalId: Int

    init(goalId: Int) {
        self.goalId = goalId
    }

    enum Action {
        case loadGoalDetail(goalId: Int)
        case deleteGoal(goalId: Int)
    }

    func send(action: Action) {
        switch action {
        case let .loadGoalDetail(goalId):
            loadState.value = .loading

            Task {
                do {
                    let detailResult = try await GoalService.getGoalDetail(of: goalId)
                    goalDetail.value = detailResult
                    loadState.value = .completed

                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }

        case let .deleteGoal(goalId):
            Task {
                do {
                    try await GoalService.deleteGoal(of: goalId)

                    NotificationCenter.default.post(name: .goalChanged, object: nil)
                    deleteSucceed.value = true
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
