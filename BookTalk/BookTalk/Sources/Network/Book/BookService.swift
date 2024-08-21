//
//  BookService.swift
//  BookTalk
//
//  Created by 김민 on 8/19/24.
//

import Foundation

struct BookService {
    
    static func getKeywords() async throws -> [Keyword] {
        let result: [KeywordResponseDTO] = try await NetworkService.shared.request(
            target: BookTarget.getKeywords
        )

        return result.map { $0.toModel() }
    }

    static func getBookDetail(of isbn: String) async throws -> DetailBookInfo {
        let params: BookDetailRequestDTO = .init(isbn: isbn)

        let result: BookDetailResponseDTO = try await NetworkService.shared.request(
            target: BookTarget.getBookDetail(params: params)
        )

        return result.toModel()
    }
}
