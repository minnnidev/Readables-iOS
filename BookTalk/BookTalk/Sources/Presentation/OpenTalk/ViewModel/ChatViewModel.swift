//
//  ChatViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import Foundation

final class ChatViewModel {

    enum Action {
        case loadChats
        case toggleBookmark
    }

    var isBookmarked = Observable(false) // TODO: 임시로 false 설정
    var chats = Observable<[ChatModel]>([])

    func send(action: Action) {

        switch action {
        case .loadChats:
            // TODO: 채팅 API 통신
            chats.value.append(contentsOf: [.chatStub1, .chatStub2, .chatStub3])

        case .toggleBookmark:
            // TODO: 채팅방 즐겨찾기 API - 요청 성공 시 토글
            isBookmarked.value.toggle()
        }
    }
}
