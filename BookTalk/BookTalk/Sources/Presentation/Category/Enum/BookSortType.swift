//
//  BookSortType.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import Foundation

enum BookSortType: CaseIterable {
    case popularityPerWeek
    case popularityPerMonth
    case newest
    case random

    var title: String {
        switch self {
        case .popularityPerWeek:
            return "일주일 인기순"
        case .popularityPerMonth:
            return "한달 인기순"
        case .newest:
            return "신작순"
        case .random:
            return "랜덤순"
        }
    }
}
