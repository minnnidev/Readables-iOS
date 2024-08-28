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
    case getGoalDetail(params: GoalDetailRequestDTO)
}

extension GoalTarget: TargetType {

    var path: String {
        switch self {
        case .postGoalCreate:
            return "api/goal/create"
        case .getGoalDetail:
            return "api/goal/get"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postGoalCreate:
            return .post
        case .getGoalDetail:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case let .postGoalCreate(params):
            return .requestParameters(parameters: params.toDictionary())
        case let .getGoalDetail(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
