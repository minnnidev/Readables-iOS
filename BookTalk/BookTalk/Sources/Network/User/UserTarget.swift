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
}

extension UserTarget: TargetType {

    var path: String {
        switch self {
        case .editUserInfo:
            return "/api/user/info/edit"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .editUserInfo:
            return .put
        }
    }
    
    var task: APITask {
        switch self {
        case let .editUserInfo(body):
            return .requestJSONEncodable(body: body)
        }
    }
}
