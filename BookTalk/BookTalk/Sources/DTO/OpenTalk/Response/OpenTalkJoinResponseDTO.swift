//
//  OpenTalkJoinResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/25/24.
//

import Foundation

struct OpenTalkJoinResponseDTO: Decodable {
    let opentalkId: Int
    let messageResponseDto: [ChatResponseDTO]
}

extension OpenTalkJoinResponseDTO {

    func toModel() -> OpenTalkModel {
        return .init(
            openTalkId: opentalkId,
            messages: messageResponseDto.map { $0.toModel() }
        )
    }
}
