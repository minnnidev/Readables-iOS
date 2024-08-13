//
//  APIEndpoint.swift
//  BookTalk
//
//  Created by 김민 on 8/14/24.
//

import Foundation
import Alamofire

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var header: HTTPHeader { get }
}

extension APIEndpoint {

    var baseURL: URL {
        return  URL(string: NetworkEnvironment.baseURL)!
    }
}
