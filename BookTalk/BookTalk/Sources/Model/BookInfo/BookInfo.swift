//
//  BookInfo.swift
//  BookTalk
//
//  Created by RAFA on 8/1/24.
//

import Foundation

struct BasicBookInfo {
    let coverImageURL: String
    let title: String
    let author: String
}

struct DetailBookInfo {
    let basicBookInfo: BasicBookInfo
    let publisher: String
    let publicationDate: String
    let isAvailable: Bool
    var isFavorite: Bool
    var distance: Double?
}