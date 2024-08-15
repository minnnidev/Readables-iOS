//
//  NetworkError.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

enum NetworkError: Error {
    case afError
    case decodingError
    case error(statusCode: Int)
}
