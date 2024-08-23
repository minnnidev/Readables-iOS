//
//  AuthTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

import Alamofire

enum AuthTarget {
    case loginWithKakao(params: LoginRequestDTO)
}

extension AuthTarget: TargetType {

    var path: String {
        switch self {
        case .loginWithKakao:
            return "/api/auth/kakaoLogin"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginWithKakao:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .loginWithKakao(params):
            return .requestWithoutInterceptor(parameters: ["idToken": params.idToken])
        }
    }
}
