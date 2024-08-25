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
    case loginWithApple(params: LoginRequestDTO)
    case logout
    case withdraw
}

extension AuthTarget: TargetType {

    var path: String {
        switch self {
        case .loginWithKakao:
            return "/api/auth/kakaoLogin"
        case .loginWithApple:
            return "/api/auth/appleLogin"
        case .logout:
            return "/api/auth/logout"
        case .withdraw:
            return "/api/auth/delete"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .loginWithKakao, 
                .loginWithApple,
                .logout:
            return .post
        case .withdraw:
            return .delete
        }
    }

    var task: APITask {
        switch self {
        case let .loginWithKakao(params),
            let .loginWithApple(params):
            return .requestWithoutInterceptor(parameters: ["idToken": params.idToken])

        case .logout, .withdraw:
            return .requestPlain 
        }
    }
}
