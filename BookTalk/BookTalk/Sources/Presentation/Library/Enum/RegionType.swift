//
//  RegionType.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

enum RegionType: CaseIterable {
    case seoul

    var name: String {
        switch self {
        case .seoul:
            return "서울"
        }
    }

    var code: String {
        switch self {
        case .seoul:
            return "11"
        }
    }
}

enum DetailRegionType: CaseIterable {
    case jongnogu
    case junggu
    case yongsangu
    case seongdonggu
    case gwangjingu
    case dongdaemungu
    case jungnanggu
    case seongbukgu
    case gangbukgu
    case dobonggu
    case nowongu
    case eunpyeonggu
    case seodaemungu
    case mapogu
    case yangcheongu
    case gangseogu
    case gurogu
    case geumcheongu

    var name: String {
        switch self {
        case .jongnogu:
            return "종로구"
        case .junggu:
            return "중구"
        case .yongsangu:
            return "용산구"
        case .seongdonggu:
            return "성동구"
        case .gwangjingu:
            return "광진구"
        case .dongdaemungu:
            return "동대문구"
        case .jungnanggu:
            return "중랑구"
        case .seongbukgu:
            return "성북구"
        case .gangbukgu:
            return "강북구"
        case .dobonggu:
            return "도봉구"
        case .nowongu:
            return "노원구"
        case .eunpyeonggu:
            return "은평구"
        case .seodaemungu:
            return "서대문구"
        case .mapogu:
            return "마포구"
        case .yangcheongu:
            return "양천구"
        case .gangseogu:
            return "강서구"
        case .gurogu:
            return "구로구"
        case .geumcheongu:
            return "금천구"
        }
    }

    var code: String {
        switch self {
        case .jongnogu:
            return "11010"
        case .junggu:
            return "11020"
        case .yongsangu:
            return "11030"
        case .seongdonggu:
            return "11040"
        case .gwangjingu:
            return "11050"
        case .dongdaemungu:
            return "11060"
        case .jungnanggu:
            return "11070"
        case .seongbukgu:
            return "11080"
        case .gangbukgu:
            return "11090"
        case .dobonggu:
            return "11100"
        case .nowongu:
            return "11110"
        case .eunpyeonggu:
            return "11120"
        case .seodaemungu:
            return "11130"
        case .mapogu:
            return "11140"
        case .yangcheongu:
            return "11150"
        case .gangseogu:
            return "11160"
        case .gurogu:
            return "11170"
        case .geumcheongu:
            return "11180"
        }
    }
}
