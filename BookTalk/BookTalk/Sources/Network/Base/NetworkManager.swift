//
//  NetworkManager.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

import Alamofire

protocol Networkable {
    func request<T: Decodable>(
        endpoint: TargetType,
        withInterceptor: Bool
    ) async throws -> T?
}

final class NetworkManager: Networkable {

    static let shared = NetworkManager()
    private let requestInterceptor: RequestInterceptor

    private init(
        requestInterceptor: ServerRequestInterceptor = .init()
    ) {
        self.requestInterceptor = requestInterceptor
    }

    func request<T: Decodable>(
        endpoint: TargetType,
        withInterceptor: Bool = true
    ) async throws -> T? {
        let interceptor = withInterceptor ? requestInterceptor : nil
        let dataRequest = createDataRequest(for: endpoint, interceptor: interceptor)

        let response = await dataRequest.validate().serializingDecodable(T.self).response

        switch response.result {
        case let .success(value):
            // 응답 헤더로부터 갱신된 accessToken 받아오기
            if let headers = response.response?.headers,
               let accessToken = headers["Authorization"] {
                saveAccessToken(accessToken)
            }

            return value

        // TODO: 에러 처리
        case let .failure(error):
            throw error
        }
    }
}

extension NetworkManager {

    private func saveAccessToken(_ accessToken: String) {
        KeychainManager.shared.save(key: TokenKey.accessToken, token: accessToken)
    }

    private func createDataRequest(
        for endpoint: TargetType,
        interceptor: RequestInterceptor?
    ) -> DataRequest {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        switch endpoint.task {
        case .requestPlain:
            return AF.request(
                url,
                method: endpoint.method,
                headers: endpoint.header,
                interceptor: interceptor
            )

        case let .requestJSONEncodable(body):
            return AF.request(
                url,
                method: endpoint.method,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: endpoint.header,
                interceptor: interceptor
            )

        case let .requestParameters(parameters):
            return AF.request(
                url,
                method: endpoint.method,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: endpoint.header,
                interceptor: interceptor
            )
        }
    }
}
