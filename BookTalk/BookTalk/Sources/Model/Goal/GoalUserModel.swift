//
//  GoalUserModel.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalUserModel {
    let profileImageURL: String
    let nickname: String
    let progressRate: Double
}

extension GoalUserModel {

    static var goalUserStub1: GoalUserModel {
        return .init(profileImageURL: "", nickname: "닉네임1", progressRate: 45.32)
    }

    static var goalUserStub2: GoalUserModel {
        return .init(profileImageURL: "", nickname: "닉네임2", progressRate: 22.33)
    }
}
