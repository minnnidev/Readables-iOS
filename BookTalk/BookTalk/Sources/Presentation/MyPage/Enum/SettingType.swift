//
//  SettingType.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

enum SettingType: CaseIterable {
    case version
    case logout
    case withdraw

    var title: String {
        switch self {
        case .version:
            "버전 정보"
        case .logout:
            "로그아웃"
        case .withdraw:
            "탈퇴하기"
        }
    }

    var content: String? {
        switch self {
        case .version:
            return Constant.appVersion
        case .logout, .withdraw:
            return nil
        }
    }
}

