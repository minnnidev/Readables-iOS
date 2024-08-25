//
//  RequestInterceptor.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

import Alamofire

final class ServerRequestInterceptor: RequestInterceptor {

    /// request 전 추가 기능
    ///
    /// - Note:
    ///     - access token, refresh token 존재 여부 체크
    ///     - 체크 후에 request header에 추가
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>
        ) -> Void) {
        guard let accessToken = KeychainManager.shared.read(key: TokenKey.accessToken),
              let _ = KeychainManager.shared.read(key: TokenKey.refreshToken) else {
            debugPrint("토큰 없음")
            completion(.success(urlRequest))
            return
        }

        var adaptedRequest = urlRequest
        adaptedRequest.headers.add(.authorization(bearerToken: accessToken))

        completion(.success(adaptedRequest))
    }

    /// request 실패 후 재시도
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: any Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        // TODO: status code 수정
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }

        guard let _ = KeychainManager.shared.read(key: TokenKey.accessToken),
              let refreshToken = KeychainManager.shared.read(key: TokenKey.refreshToken) else {
            return
        }

        Task {
            do {
                // 토큰 재발급 성공 시, 재발급 받은 토큰으로 통신 재시도
                let newTokens = try await AuthService.reissueToken(with: refreshToken)

                KeychainManager.shared.save(key: TokenKey.accessToken, token: newTokens.accessToken)
                KeychainManager.shared.save(key: TokenKey.refreshToken, token: newTokens.refreshToken)

                completion(.retry)
            } catch let error as NetworkError {
                // 재발급 불가 시, 로그아웃
                // TODO: - user default 삭제
                UserDefaults.standard.set(false, forKey: UserDefaults.Key.isLoggedIn)
                NotificationCenter.default.post(name: .authStateChanged, object: nil)

                completion(.doNotRetryWithError(error))
            }
        }
    }
}
