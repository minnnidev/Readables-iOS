//
//  BookService.swift
//  BookTalk
//
//  Created by 김민 on 8/19/24.
//

import Foundation

struct BookService {
    
    static func getKeywords() async throws -> [Keyword] {
        let result: [KeywordResponseDTO] = try await NetworkService.shared.request(
            target: BookTarget.getKeywords
        )

        return result.map { $0.toModel() }
    }

    static func getBookDetail(of isbn: String) async throws -> DetailBookInfo {
        let params: ISBNRequestDTO = .init(isbn: isbn)

        let result: BookDetailResponseDTO = try await NetworkService.shared.request(
            target: BookTarget.getBookDetail(params: params)
        )

        return result.toModel()
    }

    static func postFavoriteBook(of book: BasicBookInfo) async throws {
        let params: BookRequestDTO = .init(
            isbn: book.isbn,
            bookName: book.title,
            bookImgURL: book.coverImageURL
        )

        let _: [UserBookResponseDTO] = try await NetworkService.shared.request(
            target: BookTarget.postFavoriteBook(params: params)
        )
    }

    static func deleteFavoriteBook(of book: BasicBookInfo) async throws {
        let params: ISBNRequestDTO = .init(isbn: book.isbn)

        let _: [UserBookResponseDTO] = try await NetworkService.shared.request(
            target: BookTarget.deleteFavoriteBook(params: params)
        )
    }
}
