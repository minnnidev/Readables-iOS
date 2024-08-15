//
//  TargetType.swift
//  BookTalk
//
//  Created by 김민 on 8/14/24.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var header: HTTPHeaders? { get }
}

extension TargetType {

    var baseURL: URL {
        return  URL(string: NetworkEnvironment.baseURL)!
    }

    var header: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
