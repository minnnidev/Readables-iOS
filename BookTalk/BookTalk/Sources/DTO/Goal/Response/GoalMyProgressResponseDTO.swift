//
//  GoalMyProgressResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/30/24.
//

import Foundation

struct GoalMyProgressResponseDTO: Decodable {
    let isInProgress: Bool
    let progressRate: Double?
}

extension GoalMyProgressResponseDTO {

    func toModel() -> MyGoalModel {
        return .init(
            isInProgress: isInProgress,
            progressRate: progressRate
        )
    }
}
