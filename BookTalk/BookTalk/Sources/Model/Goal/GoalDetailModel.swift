//
//  GoalDetailModel.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalDetailModel {
    let goalId: Int
    let bookInfo: BasicBookInfo
    let startDate: String
    let recentPage: Int
    let goalModel: [GoalModel]
}
