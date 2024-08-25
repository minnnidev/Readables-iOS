//
//  ChatViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import Foundation

final class ChatViewModel {

    private(set) var isBookmarked = Observable(false)
    private(set) var chats = Observable<[ChatModel]>([])
    private(set) var message = Observable("")

    private var pageSize = 10
    private var openTalkId: Int?

    let isbn: String

    // MARK: - Initializer

    init(isbn: String) {
        self.isbn = isbn
    }

    enum Action {
        case joinToOpenTalk(isbn: String)
        case loadChats
        case toggleBookmark(isFavorite: Bool)
        case textFieldChanged(text: String)
        case sendMessage(text: String)
    }

    func send(action: Action) {

        switch action {
        case let .joinToOpenTalk(isbn):
            Task {
                do {
                    let openTalkInfo = try await OpenTalkService.postOpenTalkJoin(
                        of: isbn,
                        pageSize: pageSize
                    )

                    await MainActor.run {
                        chats.value = openTalkInfo.chats.reversed()
                        isBookmarked.value = openTalkInfo.isFavorite
                        openTalkId = openTalkInfo.openTalkId
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
            return
        case .loadChats:
            // TODO: 채팅 API 통신
            chats.value.append(contentsOf: [.chatStub1, .chatStub2, .chatStub3])

        case let .toggleBookmark(isFavorite):
            guard let id = openTalkId else { return }

            if isFavorite {
                deleteBookMark(of: id)
            } else {
                doBookMark(of: id)
            }

        case let .textFieldChanged(text):
            message.value = text

        case let .sendMessage(text):
            // TODO: 채팅 보내기 API 통신
            return
        }
    }

    private func doBookMark(of openTalkId: Int) {
        Task {
            do {
                try await OpenTalkService.postOpenTalkFavorite(of: openTalkId)

                await MainActor.run {
                    isBookmarked.value = true
                }
            } catch let error as NetworkError {
                print(error.localizedDescription)
            }
        }
    }

    private func deleteBookMark(of openTalkId: Int) {
        Task {
            do {
                try await OpenTalkService.deleteOpenTalkFavorite(of: openTalkId)

                await MainActor.run {
                    isBookmarked.value = false
                }
            } catch let error as NetworkError {
                print(error.localizedDescription)
            }
        }
    }
}
