//
//  GoalUserRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct GoalUserRequestDTO: Encodable {
    let isbn: String
    let isFinished: Bool
}
