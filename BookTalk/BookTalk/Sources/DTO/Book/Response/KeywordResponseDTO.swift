//
//  KeywordResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/19/24.
//

import Foundation

struct KeywordResponseDTO: Decodable {
    let keyword: String
    let weight: String
}

extension KeywordResponseDTO {

    func toModel() -> Keyword {
        return .init(keyword: keyword)
    }
}
