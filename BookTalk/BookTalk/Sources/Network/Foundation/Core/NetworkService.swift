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
    ) async throws -> T
}

final class NetworkService: NetworkServiceType {

    // MARK: - Properties

    static let shared = NetworkService()

    // MARK: - Initializer

    private init() { }

    // MARK: - Helpers

    func request<T: Decodable>(target: TargetType) async throws -> T {
        let dataRequest = createDataRequest(for: target)
        let response = await dataRequest
            .validate(statusCode: 200..<300)
            .serializingData()
            .response

        guard response.response != nil,
              let data = response.data else {
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(BaseResponse<T>.self, from: data)

            switch decodedData.statusCode {
            case 200..<300:
                updateAccessToken(response.response?.headers)

                guard let result = decodedData.data else {
                    throw NetworkError.invalidResponse
                }

                return result

            default:
                throw NetworkError.invalidStatusCode(
                    statusCode: decodedData.statusCode,
                    message: decodedData.message
                )
            }
        } catch is DecodingError {
            throw NetworkError.decodeError
        } catch {
            throw error
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
    }

    private func createDataRequest(for endpoint: TargetType) -> DataRequest {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let interceptor = ServerRequestInterceptor()

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
                encoding: URLEncoding.queryString,
                headers: endpoint.header,
                interceptor: interceptor
            )

        case let .requestWithoutInterceptor(parameters):
            return AF.request(
                url,
                method: endpoint.method,
                parameters: parameters,
                encoding: URLEncoding.queryString,
                headers: endpoint.header
            )
        }
    }
}
