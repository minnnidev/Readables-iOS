//
//  OpenTalkService.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct OpenTalkService {

    static func getOpenTalkMainList() async throws -> (
        hotList: [OpenTalkModel],
        favoriteList: [OpenTalkModel]
    ) {
        let result: OpenTalkMainResponseDTO = try await NetworkService.shared.request(
            target: OpenTalkTarget.getOpenTalkMain
        )

        return (
            result.hotOpenTalkList.map { $0.toModel() },
            result.favoriteOpenTalkList.map { $0.toModel() }
        )
    }
}
