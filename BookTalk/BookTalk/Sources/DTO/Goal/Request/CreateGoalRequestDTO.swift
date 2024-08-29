//
//  CreateGoalRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import Foundation

struct CreateGoalRequestDTO: Encodable {
    let isbn: String
    let totalPage: Int
}
