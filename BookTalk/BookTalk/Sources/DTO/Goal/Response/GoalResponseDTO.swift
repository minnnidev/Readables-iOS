//
//  GoalResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalResponseDTO: Decodable {
    let goalId: Int
    let userNickname: String
    let bookSummary: BookSummaryDTO
    let recentPage: Int
    let totalPage: Int
    let createdAt: String
    let updatedAt: String
    let isFinished: Bool
    let aWeekRecords: [AweekRecordDTO]?

    enum CodingKeys: String, CodingKey {
        case goalId
        case userNickname
        case bookSummary
        case recentPage
        case totalPage
        case createdAt
        case updatedAt
        case isFinished
        case aWeekRecords = "aweekRecords"
    }
}

extension GoalResponseDTO {

    func toModel() -> GoalDetailModel {
        return .init(
            goalId: goalId,
            bookInfo: bookSummary.toModel(),
            startDate: createdAt.toExtractDateString(),
            recentPage: recentPage,
            goalModel: aWeekRecords?.map { $0.toModel() } ?? [] ,
            updateDate: updatedAt.toExtractDateString(),
            createDate: createdAt.toExtractDateString()
        )
    }
}

struct BookSummaryDTO: Decodable {
    let isbn: String
    let title: String
    let author: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case isbn
        case title
        case author
        case imageURL = "imageUrl"
    }
}

extension BookSummaryDTO {

    func toModel() -> BasicBookInfo {
        return .init(
            isbn: isbn,
            coverImageURL: imageURL,
            title: title,
            author: author
        )
    }
}

struct AweekRecordDTO: Decodable {
    let date: String
    let pageInterval: Int
}

extension AweekRecordDTO {

    func toModel() -> GoalModel {
        return .init(
            day: date,
            amout: pageInterval
        )
    }
}
