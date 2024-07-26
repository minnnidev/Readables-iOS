//
//  CategorySectionKind.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import Foundation

/// 두 번째 주제 카테고리 섹션 정의
enum CategorySectionKind {
    case banner
    case category
    case allBookButton
    case newBooks
    case popularBooks

    var sectionHeight: CGFloat {
        switch self {
            
        case .banner:
            return CGFloat(160)
            
        case .category, .allBookButton:
            return CGFloat(60)
            
        case .newBooks, .popularBooks:
            return CGFloat(218)
        }
    }
}
