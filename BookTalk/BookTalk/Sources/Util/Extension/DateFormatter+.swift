//
//  DateFormatter+.swift
//  BookTalk
//
//  Created by 김민 on 8/22/24.
//

import Foundation

extension DateFormatter {

    static let koreanDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
