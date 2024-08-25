//
//  OpenTalkService.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct OpenTalkService {

    static func getOpenTalkMainList() async throws -> (
        hotList: [OpenTalkBookModel],
        favoriteList: [OpenTalkBookModel]
    ) {
        let result: OpenTalkMainResponseDTO = try await NetworkService.shared.request(
            target: OpenTalkTarget.getOpenTalkMain
        )

        return (
            result.hotOpenTalkList.map { $0.toModel() },
            result.favoriteOpenTalkList.map { $0.toModel() }
        )
    }

    static func postOpenTalkJoin(
        of isbn: String,
        pageSize: Int
    ) async throws -> OpenTalkModel {
        let params: OpenTalkJoinRequestDTO = .init(isbn: isbn, pageSize: pageSize)

        let result: OpenTalkJoinResponseDTO = try await NetworkService.shared.request(
            target: OpenTalkTarget.postOpenTalkJoin(params: params)
        )

        return result.toModel()
    }

    static func postOpenTalkFavorite(of openTalkId: Int) async throws{
        let params: OpenTalkIdRequestDTO = .init(openTalkId: openTalkId)

        let _: [Int] = try await NetworkService.shared.request(
            target: OpenTalkTarget.postFavoriteOpenTalk(params: params)
        )
    }

    static func deleteOpenTalkFavorite(of openTalkId: Int) async throws{
        let params: OpenTalkIdRequestDTO = .init(openTalkId: openTalkId)

        let _: [Int] = try await NetworkService.shared.request(
            target: OpenTalkTarget.deleteFavoriteOpenTalk(params: params)
        )
    }

    static func getChatList(
        of id: Int,
        pageNo: Int,
        pageSize: Int)
    async throws -> [ChatModel] {
        let params: ChatListRequestDTO = .init(
            opentalkId: id,
            pageNo: pageNo,
            pageSize: pageSize
        )

        let result: [ChatResponseDTO] = try await NetworkService.shared.request(
            target: OpenTalkTarget.getOpenTalkChatList(params: params)
        )

        return result.map { $0.toModel() }
    }

    static func sendMessage(of id: Int, text: String) async throws -> ChatModel {
        let params: ChatSendRequestDTO = .init(opentalkId: id, text: text)

        let result: ChatResponseDTO = try await NetworkService.shared.request(
            target: OpenTalkTarget.postChatMessage(params: params)
        )

        return result.toModel()
    }
}
