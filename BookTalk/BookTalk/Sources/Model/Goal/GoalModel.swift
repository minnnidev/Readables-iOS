//
//  GoalModel.swift
//  BookTalk
//
//  Created by 김민 on 8/9/24.
//

import Foundation

struct GoalModel {
    let day: String
    let amout: Int
}

extension GoalModel {

    static var stubGoals: [GoalModel] {
        return [
            .init(day: "월", amout: 10),
            .init(day: "화", amout: 20),
            .init(day: "수", amout: 30),
            .init(day: "목", amout: 0),
            .init(day: "금", amout: 50),
            .init(day: "토", amout: 5),
            .init(day: "일", amout: 25),
        ]
    }
}
