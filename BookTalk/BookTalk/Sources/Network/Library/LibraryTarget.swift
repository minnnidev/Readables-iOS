//
//  LibraryTarget.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

import Alamofire

enum LibraryTarget {
    case getLibrarySearchResult(params: LibrarySearchRequestDTO)
}

extension LibraryTarget: TargetType {

    var path: String {
        switch self {
        case .getLibrarySearchResult:
            return "/api/library/searchByRegion"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLibrarySearchResult:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case let .getLibrarySearchResult(params):
            return .requestParameters(parameters: params.toDictionary())
        }
    }
}
