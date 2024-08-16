//
//  GenreService.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

struct GenreService {

    static func getThisWeekTrend(with request: GenreTrendRequestDTO) async throws -> [Book] {
        do {
            let result: BaseResponse<[LoanItemResponseDTO]> = try await NetworkService.shared.request(
                target: GenreTarget.getThisWeekTrend(params: request)
            )

            return result
                .data?
                .compactMap { $0.toBookModel() } ?? []

        } catch {
            throw error
        }
    }
}

