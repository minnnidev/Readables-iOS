//
//  Interceptor.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {

    /// request 전 추가 기능
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>
        ) -> Void) {
        // TODO: request 요청 전
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
