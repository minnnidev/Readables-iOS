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
    case getBookDetail(params: ISBNRequestDTO)
    case postFavoriteBook(params: BookRequestDTO)
    case deleteFavoriteBook(params: ISBNRequestDTO)
}

extension BookTarget: TargetType {

    var path: String {
        switch self {
        case .getKeywords:
            return "/api/book/keyword"
        case .getBookDetail:
            return "/api/book/detail"
        case .postFavoriteBook:
            return "api/book/dibs/"
        case .deleteFavoriteBook:
            return "api/book/dibs/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getKeywords, .getBookDetail:
            return .get
        case .postFavoriteBook:
            return .post
        case .deleteFavoriteBook:
            return .delete
        }
    }
    
    var task: APITask {
        switch self {
        case .getKeywords:
            return .requestPlain
        case let .getBookDetail(params):
            return .requestParameters(parameters: params.toDictionary())
        case let .postFavoriteBook(params):
            return .requestParameters(parameters: params.toDictionary())
        case let .deleteFavoriteBook(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
