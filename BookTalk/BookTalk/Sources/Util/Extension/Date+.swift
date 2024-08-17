//
//  Date+.swift
//  BookTalk
//
//  Created by 김민 on 8/17/24.
//

import Foundation

extension Date {

    /// 오늘 기준으로 월, 주차를 구하는 메서드
    func currentWeekOfMonth() -> (month: Int, week: Int) {
        let koreaTimeZone = TimeZone(identifier: "Asia/Seoul")!

        var calendar = Calendar.current
        calendar.timeZone = koreaTimeZone
        calendar.firstWeekday = 2

        let components = calendar.dateComponents([.year, .month, .weekOfMonth], from: self)
        let month = components.month!
        let weekOfMonth = components.weekOfMonth!

        return (month, weekOfMonth)
    }
}
