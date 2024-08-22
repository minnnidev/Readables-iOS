//
//  UserTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/22/24.
//

import Foundation

import Alamofire

enum UserTarget {
    case editUserInfo(body: EditUserInfoRequestDTO)
    case getUserInfo
}

extension UserTarget: TargetType {

    var path: String {
        switch self {
        case .editUserInfo:
            return "/api/user/info/edit"
        case .getUserInfo:
            return "/api/user/info"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .editUserInfo:
            return .put
        case .getUserInfo:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case let .editUserInfo(body):
            return .requestJSONEncodable(body: body)
        case .getUserInfo:
            return .requestPlain
        }
    }
}
