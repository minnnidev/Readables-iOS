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
    let keywords: [String]
    let publisher: String
    let publicationDate: String
    var isFavorite: Bool
    let registeredLibraries: [Library]
}

struct Library {
    let name: String
    let isAvailable: Bool
}
