//
//  AuthService.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct AuthService {

    static func loginWithkakao(idToken: String) async throws -> Bool {
        let params: LoginRequestDTO = .init(idToken: idToken)

        let result: LoginResponseDTO = try await NetworkService.shared.request(
            target: AuthTarget.loginWithKakao(params: params)
        )

        KeychainManager.shared.save(key: TokenKey.accessToken, token: result.accessToken)
        KeychainManager.shared.save(key: TokenKey.refreshToken, token: result.refreshToken)

        return result.isNewUser
    }
}
