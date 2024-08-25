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

    static func loginWithApple(idToken: String) async throws -> Bool {
        let params: LoginRequestDTO = .init(idToken: idToken)

        let result: LoginResponseDTO = try await NetworkService.shared.request(
            target: AuthTarget.loginWithApple(params: params)
        )

        KeychainManager.shared.save(key: TokenKey.accessToken, token: result.accessToken)
        KeychainManager.shared.save(key: TokenKey.refreshToken, token: result.refreshToken)

        return result.isNewUser
    }

    static func logout() async throws {
        let _ : String = try await NetworkService.shared.request(
            target: AuthTarget.logout
        )

        KeychainManager.shared.delete(key: TokenKey.accessToken)
        KeychainManager.shared.delete(key: TokenKey.refreshToken)
    }

    static func withdraw() async throws {
        let _ : String = try await NetworkService.shared.request(
            target: AuthTarget.withdraw
        )

        KeychainManager.shared.delete(key: TokenKey.accessToken)
        KeychainManager.shared.delete(key: TokenKey.refreshToken)

        // TODO: 삭제
        UserDefaults.standard.set(false, forKey: UserDefaults.Key.isLoggedIn)
        NotificationCenter.default.post(name: .authStateChanged, object: nil)
    }
}
