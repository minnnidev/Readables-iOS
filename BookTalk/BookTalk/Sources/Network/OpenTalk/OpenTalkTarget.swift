//
//  OpenTalkTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

import Alamofire

enum OpenTalkTarget {
    case getOpenTalkMain
    case postOpenTalkJoin(params: OpenTalkJoinRequestDTO)
}

extension OpenTalkTarget: TargetType {

    var path: String {
        switch self {
        case .getOpenTalkMain:
            return "/api/opentalk/main"

        case .postOpenTalkJoin:
            return "/api/opentalk/join"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getOpenTalkMain:
            return .get
        case .postOpenTalkJoin:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case .getOpenTalkMain:
            return .requestPlain

        case let .postOpenTalkJoin(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
