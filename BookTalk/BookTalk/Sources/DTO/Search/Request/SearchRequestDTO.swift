//
//  SearchRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/22/24.
//

import Foundation

struct SearchRequestDTO: Encodable {
    let isKeyword: Bool
    let input: String
    let pageNo: Int
    let pageSize: Int
}
