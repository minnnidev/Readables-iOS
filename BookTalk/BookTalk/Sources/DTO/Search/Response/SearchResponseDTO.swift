//
//  SearchResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/19/24.
//

import Foundation

struct SearchResponseDTO: Decodable {
    let bookName: String
    let authors: String
    let publisher: String
    let publicationYear: String
    let isbn13: String
    let vol: String
    let bookImageURL: String
    let bookDtlURL: String
    let loanCount: String
    let dibs: Bool
    let loanAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case bookName = "bookname"
        case authors
        case publisher
        case publicationYear = "publication_year"
        case isbn13
        case vol
        case bookImageURL
        case bookDtlURL = "bookDtlUrl"
        case loanCount = "loan_count"
        case dibs
        case loanAvailable
    }
}

extension SearchResponseDTO {

    func toModel() -> DetailBookInfo {
        return .init(
            basicBookInfo: .init(
                isbn: isbn13,
                coverImageURL: bookImageURL,
                title: bookName,
                author: authors
            ),
            keywords: .init(),
            publisher: publisher,
            publicationDate: publicationYear,
            isFavorite: dibs, 
            registeredLibraries: .init()
        )
    }
}

