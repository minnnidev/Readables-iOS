//
//  ChatViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import Foundation

final class ChatViewModel {

    var isBookmarked = Observable(false) // TODO: 임시로 false 설정
    var chats = Observable<[ChatModel]>([])
    var message = Observable("")

    private let isbn: String

    // MARK: - Initializer

    init(isbn: String) {
        self.isbn = isbn
    }

    enum Action {
        case loadChats
        case toggleBookmark
        case textFieldChanged(text: String)
        case sendMessage(text: String)
    }

    func send(action: Action) {

        switch action {
        case .loadChats:
            // TODO: 채팅 API 통신
            chats.value.append(contentsOf: [.chatStub1, .chatStub2, .chatStub3])

        case .toggleBookmark:
            // TODO: 채팅방 즐겨찾기 API - 요청 성공 시 토글
            isBookmarked.value.toggle()

        case let .textFieldChanged(text):
            message.value = text

        case let .sendMessage(text):
            // TODO: 채팅 보내기 API 통신
            return
        }
    }
}
