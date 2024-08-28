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
}

extension GoalTarget: TargetType {

    var path: String {
        switch self {
        case .postGoalCreate:
            return "api/goal/create"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postGoalCreate:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .postGoalCreate(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
