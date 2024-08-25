//
//  HotTrendResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/26/24.
//

import Foundation

struct HotTrendResponseDTO: Decodable {
    let no: String?
    let difference: String?
    let baseWeekRank: String?
    let pastWeekRank: String?
    let bookName: String
    let authors: String?
    let publisher: String?
    let publicationYear: String?
    let isbn13: String
    let additionSymbol: String?
    let vol: String?
    let classNo: String?
    let classNm: String?
    let bookImageURL: String
    let bookDtlUrl: String

    enum CodingKeys: String, CodingKey {
        case no
        case difference
        case baseWeekRank
        case pastWeekRank
        case bookName = "bookname"
        case authors
        case publisher
        case publicationYear = "publication_year"
        case isbn13
        case additionSymbol = "addition_symbol"
        case vol
        case classNo = "class_no"
        case classNm = "class_nm"
        case bookImageURL
        case bookDtlUrl
    }
}

extension HotTrendResponseDTO {

    func toModel() -> Book {
        return .init(
            isbn: isbn13,
            imageURL: bookImageURL,
            title: bookName
        )
    }
}
