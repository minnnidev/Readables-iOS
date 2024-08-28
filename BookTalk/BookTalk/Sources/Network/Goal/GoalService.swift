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

        let result: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.postGoalCreate(params: params)
        )

    }
}
