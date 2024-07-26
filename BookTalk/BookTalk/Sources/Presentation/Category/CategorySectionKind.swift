//
//  CategorySectionKind.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import Foundation

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
