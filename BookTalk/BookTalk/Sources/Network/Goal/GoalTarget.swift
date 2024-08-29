//
//  GoalTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

import Alamofire

enum GoalTarget {
    case postGoalCreate(params: CreateGoalRequestDTO)
    case getGoalDetail(params: GoalRequestDTO)
    case deleteGoal(params: GoalRequestDTO)
    case putCompleteGoal(params: GoalRequestDTO)
    case getUserGoals(params: LoadGoalRequestDTO)
    case getTotalWeekGoals
}

extension GoalTarget: TargetType {
    
    var path: String {
        switch self {
        case .postGoalCreate:
            return "/api/goal/create"
        case .getGoalDetail:
            return "/api/goal/get"
        case .deleteGoal:
            return "/api/goal/delete"
        case .putCompleteGoal:
            return "/api/goal/finish"
        case .getUserGoals:
            return "/api/goal/get/total"
        case .getTotalWeekGoals:
            return "/api/goal/get/totalAWeek"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postGoalCreate:
            return .post
        case .getGoalDetail, .getUserGoals, .getTotalWeekGoals:
            return .get
        case .deleteGoal:
            return .delete
        case .putCompleteGoal:
            return .put
        }
    }
    
    var task: APITask {
        switch self {
        case let .postGoalCreate(params):
            return .requestParameters(parameters: params.toDictionary())

        case let .getGoalDetail(params),
            let .deleteGoal(params),
            let .putCompleteGoal(params):
            return .requestParameters(parameters: params.toDictionary())

        case let .getUserGoals(params):
            return .requestParameters(parameters: params.toDictionary())
            
        case .getTotalWeekGoals:
            return .requestPlain
        }
    }
}
