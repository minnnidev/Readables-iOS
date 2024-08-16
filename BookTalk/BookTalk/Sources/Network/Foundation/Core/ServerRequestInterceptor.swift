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
            // TODO: 키체인에 토큰 존재하지 않을 시 에러 - ex. 로그아웃
            debugPrint("토큰 없음 - 요청 불가")
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
        // TODO: JWT Token 갱신 로직 추가 -> 갱신 실패 시 로그아웃
    }
}
