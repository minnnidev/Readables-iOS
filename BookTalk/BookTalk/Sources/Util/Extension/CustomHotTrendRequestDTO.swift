//
//  CustomHotTrendRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/26/24.
//

import Foundation

struct CustomHotTrendRequestDTO: Encodable {
    var weekMonth: String? = nil
    var peerAge: String? = nil
    var ageRange: String? = nil
    var gender: String? = nil
    var genreCode: String? = nil
    var region: String? = nil
    var libCode: String? = nil
}
