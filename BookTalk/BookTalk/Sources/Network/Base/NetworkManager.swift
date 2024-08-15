//
//  NetworkManager.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

import Alamofire

protocol Networkable {
    func request<T: Decodable>(endpoint: TargetType) async throws -> T?
}

final class NetworkManager: Networkable {

    static let shared = NetworkManager()

    private init() { }

    func request<T: Decodable>(endpoint: TargetType) async throws -> T? {
        let dataRequest = createDataRequest(for: endpoint)

        do {
            let response = try await dataRequest.validate().serializingDecodable(T.self).value
            return response
        } catch let afError as AFError {
            print(afError.localizedDescription)
            throw NetworkError.afError
        } catch let decodingError as DecodingError {
            print(decodingError.localizedDescription)
            throw NetworkError.decodingError
        } catch {
            print(error.localizedDescription)
            throw NetworkError.error
        }
    }
    private func createDataRequest(for endpoint: TargetType) -> DataRequest {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        switch endpoint.task {
        case .requestPlain:
            return AF.request(
                url,
                method: endpoint.method,
                headers: endpoint.header,
                interceptor: RequestInterceptor()
            )

        case let .requestJSONEncodable(body):
            return AF.request(
                url,
                method: endpoint.method,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: endpoint.header,
                interceptor: Interceptor()
            )

        case let .requestParameters(parameters):
            return AF.request(
                url,
                method: endpoint.method,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: endpoint.header,
                interceptor: Interceptor()
            )
        }
    }
}
