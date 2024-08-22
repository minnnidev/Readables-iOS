//
//  BookTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/19/24.
//

import Foundation

import Alamofire

enum BookTarget {
    case getKeywords
    case getBookDetail(params: BookDetailRequestDTO)
}

extension BookTarget: TargetType {

    var path: String {
        switch self {
        case .getKeywords:
            return "/api/book/keyword"
        case let .getBookDetail(params):
            return "/api/book/detail"
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
        case .getKeywords:
            return .requestPlain
        case let .getBookDetail(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
