//
//  BookRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/24/24.
//

import Foundation

struct BookRequestDTO: Encodable {
    let isbn: String
    let bookName: String
    let bookImgURL: String

    enum CodingKeys: String, CodingKey {
        case isbn
        case bookName = "bookname"
        case bookImgURL = "bookImgUrl"
    }
}
