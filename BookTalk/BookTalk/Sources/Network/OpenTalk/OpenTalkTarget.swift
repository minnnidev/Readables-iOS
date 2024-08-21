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
}

extension OpenTalkTarget: TargetType {

    var path: String {
        switch self {
        case .getOpenTalkMain:
            return "/api/opentalk/main"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getOpenTalkMain:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case .getOpenTalkMain:
            return .requestPlain
        }
    }
}
