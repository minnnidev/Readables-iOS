//
//  String+.swift
//  BookTalk
//
//  Created by 김민 on 8/24/24.
//

import Foundation

extension String {

    func toKoreanAge() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let birthDate = dateFormatter.date(from: self) else {
            return "Invalid date format"
        }

        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let birthYear = calendar.component(.year, from: birthDate)

        var koreanAge = currentYear - birthYear + 1

        let birthMonthDay = calendar.dateComponents([.month, .day], from: birthDate)
        let currentMonthDay = calendar.dateComponents([.month, .day], from: Date())

        if currentMonthDay.month! < birthMonthDay.month! ||
            (currentMonthDay.month! == birthMonthDay.month! && currentMonthDay.day! < birthMonthDay.day!) {
            koreanAge -= 1
        }

        return "\(koreanAge)"
    }

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) 

        return dateFormatter.date(from: self)
    }

    func toExtractDateString() -> String {
        let dateTimeParts = self.split(separator: "T")
        return dateTimeParts.first.map { String($0) } ?? ""
    }
}
