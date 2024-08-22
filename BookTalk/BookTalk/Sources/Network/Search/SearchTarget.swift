//
//  SearchTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

import Alamofire

enum SearchTarget {
    case getSearchResult(params: SearchRequestDTO)
}

extension SearchTarget: TargetType {

    var path: String {
        switch self {
        case .getSearchResult:
            return "/api/book/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getSearchResult:
            return .get
        }
    }

    var task: APITask {
        switch self {
        case let .getSearchResult(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
