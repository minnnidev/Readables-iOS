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
}

extension AuthTarget: TargetType {

    var path: String {
        switch self {
        case .loginWithKakao:
            return "/api/auth/kakaoLogin"
        case .loginWithApple:
            return "/api/auth/appleLogin"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .loginWithKakao, .loginWithApple:
            return .post
        }
    }

    var task: APITask {
        switch self {
        case let .loginWithKakao(params),
            let .loginWithApple(params):
            return .requestWithoutInterceptor(parameters: ["idToken": params.idToken])
        }
    }
}
