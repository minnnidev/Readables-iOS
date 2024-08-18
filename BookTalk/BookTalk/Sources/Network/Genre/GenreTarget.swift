//
//  GenreTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/16/24.
//

import Foundation

import Alamofire

enum GenreTarget {
    case getThisWeekTrend(params: GenreTrendRequestDTO)
    case getNewTrend(params: GenreTrendRequestDTO)
}

extension GenreTarget: TargetType {
    
    var path: String {
        switch self {
        case .getThisWeekTrend:
            return "/api/genre/thisWeekTrend"
        case .getNewTrend:
            return "/api/genre/newTrend"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getThisWeekTrend, .getNewTrend:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case let .getThisWeekTrend(params),
            let .getNewTrend(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
