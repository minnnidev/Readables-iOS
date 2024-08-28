//
//  GoalService.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalService {

    static func createGoal(with isbn: String, totalPage: Int) async throws {
        let params: CreateGoalRequestDTO = .init(isbn: isbn, totalPage: totalPage)

        let _: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.postGoalCreate(params: params)
        )
    }

    static func getGoalDetail(of goalId: Int) async throws -> GoalDetailModel {
        let params: GoalDetailRequestDTO = .init(goalId: goalId)

        let result: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.getGoalDetail(params: params)
        )

        return result.toModel()
    }
}
