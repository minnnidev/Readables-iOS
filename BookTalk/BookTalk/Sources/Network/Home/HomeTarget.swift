//
//  HomeTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/26/24.
//

import Foundation

import Alamofire

enum HomeTarget {
    case getHotTrend
    case getCustomHotTrend(params: CustomHotTrendRequestDTO)
}

extension HomeTarget: TargetType {

    var path: String {
        switch self {
        case .getHotTrend:
            return "/api/book/hotTrend"
        case .getCustomHotTrend:
            return "/api/book/customHotTrend"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case .getHotTrend:
            return .requestPlain
        case let .getCustomHotTrend(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
