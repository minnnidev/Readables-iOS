//
//  ChatResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/25/24.
//

import Foundation

struct ChatResponseDTO: Decodable {
    let nickname: String?
    let content: String
    let createdAt: String
}

extension ChatResponseDTO {

    func toModel() -> ChatModel {
        return .init(
            nickname: nickname ?? "이름 없음", // TODO: 지우기
            message: content,
            isMine: nickname == UserData.shared.getUser()?.nickname
        )
    }
}
