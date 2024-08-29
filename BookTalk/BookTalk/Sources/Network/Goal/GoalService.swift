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
        let params: GoalRequestDTO = .init(goalId: goalId)

        let result: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.getGoalDetail(params: params)
        )

        return result.toModel()
    }

    static func completeGoal(of goalId: Int) async throws {
        let params: GoalRequestDTO = .init(goalId: goalId)

        let _: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.putCompleteGoal(params: params)
        )
    }

    static func deleteGoal(of goalId: Int) async throws {
        let params: GoalRequestDTO = .init(goalId: goalId)

        let _: String = try await NetworkService.shared.request(
            target: GoalTarget.deleteGoal(params: params)
        )
    }

    static func getUserGoal(isFinished: Bool) async throws -> [GoalDetailModel] {
        let params: LoadGoalRequestDTO = .init(isFinished: isFinished)

        let result: [GoalResponseDTO] = try await NetworkService.shared.request(
            target: GoalTarget.getUserGoals(params: params)
        )

        return result.map { $0.toModel() }
    }

    static func getAWeekTotal() async throws -> [GoalModel] {
        let result: [AweekRecordDTO] = try await NetworkService.shared.request(
            target: GoalTarget.getTotalWeekGoals
        )
        return result.map { $0.toModel() }
    }

    static func postTodayRecord(of goalId: Int, page: Int) async throws {
        let params: AddRecordReqeustDTO = .init(goalId: goalId, recentPage: page)

        let _: GoalResponseDTO = try await NetworkService.shared.request(
            target: GoalTarget.postRecord(params: params)
        )
    }

    static func getGoalUserState(of isbn: String, isFinished: Bool) async throws -> [GoalUserModel] {
        let params: GoalUserRequestDTO = .init(isbn: isbn, isFinished: isFinished)

        let result: [GoalUserResponseDTO] = try await NetworkService.shared.request(
            target: GoalTarget.getGoalUsersState(params: params)
        )

        return result.map { $0.toModel() }
    }
}
