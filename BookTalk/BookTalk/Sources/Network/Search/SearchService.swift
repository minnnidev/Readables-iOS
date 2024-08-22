//
//  SearchService.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct SearchService {

    static func getSearchResult(with requestDTO: SearchRequestDTO) async throws -> [DetailBookInfo] {
        let result: [SearchResponseDTO] = try await NetworkService.shared.request(
            target: SearchTarget.getSearchResult(params: requestDTO)
        )

        return result.map { $0.toModel() }
    }

    static func getSearchSimpleRsult(
        input: String,
        pageNo: Int,
        pageSize: Int
    ) async throws -> [Book] {
        let params: SearchRequestDTO = .init(
            isKeyword: false,
            input: input,
            pageNo: pageNo,
            pageSize: pageSize
        )

        let result: [SearchResponseDTO] = try await NetworkService.shared.request(
            target: SearchTarget.getSearchResult(params: params)
        )

        return result.map { $0.toModel() }
    }
}
