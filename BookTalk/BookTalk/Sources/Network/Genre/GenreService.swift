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

    static func getBooksByFilter(of filter: BookSortType, with requestDTO: GenreTrendRequestDTO) async throws -> [Book] {
        var result: [LoanItemResponseDTO] = .init()

        switch filter {
        case .popularityPerWeek:
            result = try await NetworkService.shared.request(
                target: GenreTarget.getWeekTrend(params: requestDTO)
            )

        case .popularityPerMonth:
            result = try await NetworkService.shared.request(
                target: GenreTarget.getMonthTrend(params: requestDTO)
            )

        case .newest, .random:
            break
        }

        return result.map { $0.toBookModel() }
    }

    static func getRandomBooks(with requestDTO: GenreRandomRequestDTO) async throws -> [Book] {
        let result: [LoanItemResponseDTO] = try await NetworkService.shared.request(
            target: GenreTarget.getRandom(params: requestDTO)
        )

        return result.map { $0.toBookModel() }
    }
}
