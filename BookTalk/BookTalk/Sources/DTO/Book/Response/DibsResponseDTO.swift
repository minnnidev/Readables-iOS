//
//  DibsResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct DibResponseDTO: Decodable {
    let isbn: String
    let bookName: String
    let bookImageURL: String

    enum CodingKeys: String, CodingKey {
        case isbn
        case bookName = "bookname"
        case bookImageURL
    }
}

extension DibResponseDTO {

    func toModel() -> Book {
        return .init(
            isbn: isbn,
            imageURL: bookImageURL,
            title: bookName
        )
    }
}
