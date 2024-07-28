//
//  Category.swift
//  BookTalk
//
//  Created by 김민 on 7/28/24.
//

import Foundation

struct Category {
    let firstCatgory: String
    let secondCategory: String
}

extension Category {

    static var secondCategories: [String] {
        return ["전체", "카테고리1", "카테고리2", "카테고리3", "카테고리4", "카테고리5", "카테고리6"]
    }
}
