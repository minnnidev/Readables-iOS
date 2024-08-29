//
//  ChatModel.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import Foundation

enum ChatType: String {
    case text = "text"
    case img = "img"
}

struct ChatModel {
    let nickname: String
    let message: String
    let isMine: Bool
}

extension ChatModel {

    static var chatStub1: ChatModel {
        .init(
            nickname: "테스트",
            message: "청소년 시절에 히가시노게이고 추리소설들을 너무 재미있게 봐서 구매했는데 역시 다른느낌으로 너무 재미있게 읽었습니다 몽글몽글하네요",
            isMine: false
        )
    }

    static var chatStub2: ChatModel {
        .init(
            nickname: "테스트",
            message: "쫄깃쫄깃한 스릴을 좋아하는 분에게는 비추해요",
            isMine: false
        )
    }

    static var chatStub3: ChatModel {
        .init(
            nickname: "테스트",
            message: "안녕하세요!",
            isMine: true
        )
    }
}
