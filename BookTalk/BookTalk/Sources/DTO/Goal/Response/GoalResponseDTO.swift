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
    let recentPage: String?
    let totalPage: String
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

struct AweekRecordDTO: Decodable {
    let date: String
    let recentPage: Int
}
