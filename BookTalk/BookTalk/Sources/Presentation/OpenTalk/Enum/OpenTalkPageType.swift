//
//  OpenTalkPageType.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import Foundation

enum OpenTalkPageType: CaseIterable {
    case hot
    case liked

    var title: String {
        switch self {
        case .hot:
            return "현재 핫한 오픈톡"
        case .liked:
            return "즐겨찾기한 오픈톡"
        }
    }
}
