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
    case getRandom(params: GenreRandomRequestDTO)
    case getWeekTrend(params: GenreTrendRequestDTO)
    case getMonthTrend(params: GenreTrendRequestDTO)
}

extension GenreTarget: TargetType {
    
    var path: String {
        switch self {
        case .getThisWeekTrend:
            return "/api/genre/thisWeekTrend"
        case .getNewTrend:
            return "/api/genre/newTrend"
        case .getRandom:
            return "/api/genre/random"
        case .getWeekTrend:
            return "/api/genre/aWeekTrend"
        case .getMonthTrend:
            return "/api/genre/aMonthTrend"
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
        case let .getThisWeekTrend(params),
            let .getNewTrend(params),
            let .getWeekTrend(params),
            let .getMonthTrend(params):
            return .requestParameters(parameters: params.toDictionary())

        case let .getRandom(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
