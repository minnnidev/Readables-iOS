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
        target: TargetType,
        withInterceptor: Bool
    ) async throws -> BaseResponse<T>
}

final class NetworkService: NetworkServiceType {

    static let shared = NetworkService()
    private let requestInterceptor: RequestInterceptor

    private init(
        requestInterceptor: ServerRequestInterceptor = .init()
    ) {
        self.requestInterceptor = requestInterceptor
    }

    func request<T>(
        target: TargetType,
        withInterceptor: Bool = true
    ) async throws -> BaseResponse<T> {
        let interceptor = withInterceptor ? requestInterceptor : nil
        let dataRequest = createDataRequest(for: target, interceptor: interceptor)
        let data: Data

        do {
            data = try await dataRequest.validate().serializingData().value
        } catch {
            throw handleNetworkError(error)
        }

        do {
            let decodedData = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError
        }
    }
}


extension NetworkService {

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
