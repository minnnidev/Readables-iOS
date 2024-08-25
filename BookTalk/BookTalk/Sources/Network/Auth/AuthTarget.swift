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
    case reissueToken(params: ReissueTokenRequestDTO)
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
        case .reissueToken:
            return "/api/auth/reissueToken"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .loginWithKakao, 
                .loginWithApple,
                .logout,
            .reissueToken:
            return .post
        case .withdraw:
            return .delete
        }
    }

    var task: APITask {
        switch self {
        case let .loginWithKakao(params),
            let .loginWithApple(params):
            return .requestWithoutInterceptor(parameters: params.toDictionary())

        case .logout, .withdraw:
            return .requestPlain 

        case let .reissueToken(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
