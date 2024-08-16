//
//  NetworkManager.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

import Alamofire

protocol NetworkServiceType {
    func request<T: Decodable>(
        target: TargetType
    ) async throws -> BaseResponse<T>

    func requestWithoutInterceptor<T: Decodable>(
        target: TargetType
    ) async throws -> BaseResponse<T>
}

final class NetworkService: NetworkServiceType {

    // MARK: - Properties

    static let shared = NetworkService()
    private let requestInterceptor: RequestInterceptor

    // MARK: - Initializer

    private init(
        requestInterceptor: ServerRequestInterceptor = .init()
    ) {
        self.requestInterceptor = requestInterceptor
    }

    // MARK: - Helpers

    func request<T>(
        target: TargetType
    ) async throws -> BaseResponse<T> {
        return try await request(target: target, withInterceptor: true)
    }

    func requestWithoutInterceptor<T>(
        target: TargetType
    ) async throws -> BaseResponse<T> {
        return try await request(target: target, withInterceptor: false)
    }

    private func request<T>(
        target: TargetType,
        withInterceptor: Bool
    ) async throws -> BaseResponse<T> {
        let interceptor = withInterceptor ? requestInterceptor : nil
        let dataRequest = createDataRequest(for: target, interceptor: interceptor)
        let response = await dataRequest.validate().serializingData().response

        switch response.result {
        case let .success(data):
            do {
                updateAccessToken(response.response?.headers)

                let decodedData = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodeError
            }

        case let .failure(error):
            throw handleNetworkError(error)
        }
    }
}

extension NetworkService {

    // 요청 성공 시 response의 header로 받은 access token으로 갱신
    private func updateAccessToken(_ headers: HTTPHeaders?) {
        guard let headers = headers,
              let authorizationHeader = headers["Authorization"],
              authorizationHeader.starts(with: "Bearer ") else {
            return
        }

        let newAccessToken = String(authorizationHeader.dropFirst("Bearer ".count))
        KeychainManager.shared.save(key: TokenKey.accessToken, token: newAccessToken)
        debugPrint("요청 성공: access token 갱신 완료")
    }

    private func handleNetworkError(_ error: Error) -> NetworkError {
        guard let afError = error.asAFError else { return .unknownError }

        switch afError {
        case .invalidURL:
            return .invalidURL
        case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
            return .invalidStatusCode(statusCode: code)
        case .sessionTaskFailed:
            return .serverUnavailable
        default:
            return .unknownError
        }
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
