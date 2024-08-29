//
//  GoalUserResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalUserResponseDTO: Decodable {
    let profileImageUrl: String?
    let nickname: String
    let progressRate: Double
}

extension GoalUserResponseDTO {

    func toModel() -> GoalUserModel {
        return .init(
            profileImageURL: profileImageUrl ?? "", 
            nickname: nickname,
            progressRate: progressRate
        )
    }
}
