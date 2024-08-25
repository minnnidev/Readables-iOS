//
//  OpenTalkIdRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/25/24.
//

import Foundation

struct OpenTalkIdRequestDTO: Encodable {
    let openTalkId: Int

    enum CodingKeys: String, CodingKey {
        case openTalkId = "opentalkId"
    }
}
