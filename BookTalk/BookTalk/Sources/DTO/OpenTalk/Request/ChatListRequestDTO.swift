//
//  ChatListRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/21/24.
//

import Foundation

struct ChatListRequestDTO: Encodable {
    let opentalkId: Int
    let pageNo: Int
    let pageSize: Int
}
