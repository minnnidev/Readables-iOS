//
//  GenreService.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

protocol GenreServiceType {
    func getThisWeekTrend(with request: GenreTrendRequestDTO) async throws -> [Book]
}

final class GenreService: GenreServiceType {

    private let networkService: NetworkServiceType

    init(
        networkService: NetworkServiceType = NetworkService.shared
    ) {
        self.networkService = networkService
    }

    func getThisWeekTrend(with request: GenreTrendRequestDTO) async throws -> [Book] {
        do {
            let result: BaseResponse<[LoanItemResponseDTO]> = try await networkService.request(
                target: GenreTarget.getThisWeekTrend(params: request)
            )

            print(result)

            return result.data!.map { $0.toBookModel() }

        } catch {
            throw error
        }
    }
}
