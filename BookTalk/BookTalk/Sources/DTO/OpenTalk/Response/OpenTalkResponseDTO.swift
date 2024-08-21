//
//  OpenTalkResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct OpenTalkMainResponseDTO: Decodable {
    let hotOpenTalkList: [OpenTalkResponseDTO]
    let favoriteOpenTalkList: [OpenTalkResponseDTO]

    enum CodingKeys: String, CodingKey {
        case hotOpenTalkList = "hotOpentalkList"
        case favoriteOpenTalkList = "favoriteOpentalkList"
    }
}

struct OpenTalkResponseDTO: Decodable {
    let id: Int
    let bookName: String
    let bookImageURL: String
}

extension OpenTalkResponseDTO {

    func toModel() -> OpenTalkModel {
        return .init(
            id: id,
            bookName: bookName,
            bookImageURL: bookImageURL
        )
    }
}
