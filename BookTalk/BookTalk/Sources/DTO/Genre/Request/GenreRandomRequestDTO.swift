//
//  GenreRandomRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/18/24.
//

import Foundation

struct GenreRandomRequestDTO: Encodable {
    let genreCode: String
    let maxSize: String
}
