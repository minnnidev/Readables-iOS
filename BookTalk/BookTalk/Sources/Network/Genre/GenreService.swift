//
//  GenreService.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

struct GenreService {

    static func getThisWeekTrend(with requestDTO: GenreTrendRequestDTO) async throws -> [Book] {
        let result: [LoanItemResponseDTO] = try await NetworkService.shared.request(
            target: GenreTarget.getThisWeekTrend(params: requestDTO)
        )

        return result.map { $0.toBookModel() }
    }

    static func getNewTrend(with requestDTO: GenreTrendRequestDTO) async throws -> [Book] {
        let result: [LoanItemResponseDTO] = try await NetworkService.shared.request(
            target: GenreTarget.getNewTrend(params: requestDTO)
        )

        return result.map { $0.toBookModel() }
    }
}
