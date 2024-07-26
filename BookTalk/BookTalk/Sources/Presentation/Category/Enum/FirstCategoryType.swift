//
//  FirstCategoryType.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import Foundation

enum FirstCategoryType: CaseIterable {
    case philosophy
    case religion
    case socialScience
    case naturalScience
    case descriptiveScience
    case art
    case linguistic
    case literature
    case history

    var title: String {
        switch self {
        case .philosophy:
            return "철학"
        case .religion:
            return "종교"
        case .socialScience:
            return "사회과학"
        case .naturalScience:
            return "자연과학"
        case .descriptiveScience:
            return "기술과학"
        case .art:
            return "예술"
        case .linguistic:
            return "언어"
        case .literature:
            return "문학"
        case .history:
            return "역사"
        }
    }
}
