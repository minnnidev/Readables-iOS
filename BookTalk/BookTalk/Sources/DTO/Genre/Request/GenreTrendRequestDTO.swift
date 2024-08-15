//
//  GenreTrendRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

struct GenreTrendRequestDTO: Encodable {
    let genreCode: String
    let pageNo: String
    let pageSize: String
}
