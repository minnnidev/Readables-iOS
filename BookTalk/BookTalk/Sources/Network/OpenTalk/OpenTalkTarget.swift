//
//  OpenTalkTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

import Alamofire

enum OpenTalkTarget {
    case getOpenTalkMain
    case postOpenTalkJoin(params: OpenTalkJoinRequestDTO)
    case postFavoriteOpenTalk(params: OpenTalkIdRequestDTO)
    case deleteFavoriteOpenTalk(params: OpenTalkIdRequestDTO)
    case getOpenTalkChatList(params: ChatListRequestDTO)
    case postChatMessage(params: ChatSendRequestDTO)
}

extension OpenTalkTarget: TargetType {
    
    var path: String {
        switch self {
        case .getOpenTalkMain:
            return "/api/opentalk/main"
        case .postOpenTalkJoin:
            return "/api/opentalk/join"
        case .postFavoriteOpenTalk:
            return "/api/opentalk/favorite"
        case .deleteFavoriteOpenTalk:
            return "/api/opentalk/favorite"
        case .getOpenTalkChatList:
            return "/api/message/get"
        case .postChatMessage:
            return "/api/message/save"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getOpenTalkMain, .getOpenTalkChatList:
            return .get
        case .postOpenTalkJoin, 
                .postFavoriteOpenTalk,
                .postChatMessage:
            return .post
        case .deleteFavoriteOpenTalk:
            return .delete
        }
    }
    
    var task: APITask {
        switch self {
        case .getOpenTalkMain:
            return .requestPlain
            
        case let .postOpenTalkJoin(params):
            return .requestParameters(parameters: params.toDictionary())
            
        case let .postFavoriteOpenTalk(params),
            let .deleteFavoriteOpenTalk(params):
            return .requestParameters(parameters: params.toDictionary())

        case let .getOpenTalkChatList(params):
            return .requestParameters(parameters: params.toDictionary())

        case let .postChatMessage(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
