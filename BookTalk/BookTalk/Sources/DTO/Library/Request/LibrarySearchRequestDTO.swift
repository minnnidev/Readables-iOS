//
//  LibrarySearchRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct LibrarySearchRequestDTO: Encodable {
    let regionCode: String
    let regionDetailCode: String
}
