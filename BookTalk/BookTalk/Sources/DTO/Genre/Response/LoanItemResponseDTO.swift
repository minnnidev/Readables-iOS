//
//  LoanItemResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

struct LoanItemResponseDTO: Decodable {
    let no: String
    let ranking: String
    let bookName: String
    let authors: String
    let publisher: String
    let publicationYear: String
    let isbn13: String
    let additionSymbol: String
    let classNo: String
    let classNm: String
    let loanCount: String
    let bookImageURL: String
    let bookDtlUrl: String

    enum CodingKeys: String, CodingKey {
        case no
        case ranking
        case bookName = "bookname"
        case authors
        case publisher
        case publicationYear = "publication_year"
        case isbn13
        case additionSymbol = "addition_symbol"
        case classNo = "class_no"
        case classNm = "class_nm"
        case loanCount = "loan_count"
        case bookImageURL = "bookImageURL"
        case bookDtlUrl = "bookDtlUrl"
    }
}

extension LoanItemResponseDTO {

    func toBookModel() -> Book {
        .init(
            isbn: isbn13,
            imageURL: bookImageURL,
            title: bookName
        )
    }
}
