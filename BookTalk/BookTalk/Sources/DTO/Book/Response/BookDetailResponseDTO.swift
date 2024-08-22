//
//  BookDetailResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/21/24.
//

import Foundation

struct BookDetailResponseDTO: Codable {
    let bookInfoDto: BookInfoDTO
    let top3LoanUserDtoList: [Top3LoanUserDTO]
    let keywordDtoList: [String]
    let coLoanBooksDtoList: [CoLoanBooksDTO]
    let recommendResponseDtoList: [RecommendResponseDTO]
    let loanAvailableList: [LoanAvailableDTO]
    let dibs: Bool
}

extension BookDetailResponseDTO {

    func toModel() -> DetailBookInfo {
        return .init(
            basicBookInfo: .init(
                isbn: bookInfoDto.isbn13, 
                coverImageURL: bookInfoDto.bookImageURL,
                title: bookInfoDto.bookname,
                author: bookInfoDto.authors
            ),
            keywords: keywordDtoList,
            publisher: bookInfoDto.publisher,
            publicationDate: bookInfoDto.publication_year,
            isFavorite: dibs,
            registeredLibraries: loanAvailableList.map { $0.toModel() }
        )
    }
}

struct BookInfoDTO: Codable {
    let bookname: String
    let authors: String
    let publisher: String
    let bookImageURL: String
    let description: String
    let publication_year: String
    let isbn13: String
    let vol: String
    let class_no: String
    let class_nm: String
    let loanCnt: String
}

struct Top3LoanUserDTO: Codable {
    let age: String
    let gender: String
    let loanCnt: String
    let ranking: String
}

struct CoLoanBooksDTO: Codable {
    let bookname: String
    let authors: String
    let publisher: String
    let publication_year: String
    let isbn13: String
    let vol: String
    let loanCnt: String
}

struct RecommendResponseDTO: Codable {
    let bookname: String
    let authors: String
    let publisher: String
    let publication_year: String
    let isbn13: String
    let vol: String
}

struct LoanAvailableDTO: Codable {
    let libCode: String
    let libName: String
    let loanable: Bool
}

extension LoanAvailableDTO {

    func toModel() -> Library {
        return .init(
            name: libName,
            isAvailable: loanable
        )
    }
}
