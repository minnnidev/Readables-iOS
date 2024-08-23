//
//  LibraryService.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct LibraryService {

    static func getLibrarySearchResult(
        region: RegionType,
        detailRegion: DetailRegion
    ) async throws -> [LibraryInfo] {
        let params: LibrarySearchRequestDTO = .init(
            regionCode: region.code,
            regionDetailCode: detailRegion.code
        )

        let result: [LibraryInfoResponseDTO] = try await NetworkService.shared.request(target: LibraryTarget.getLibrarySearchResult(params: params))

        return result.map { $0.toModel() }
    }
}
