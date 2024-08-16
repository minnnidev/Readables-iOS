//
//  BaseResponse.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let statusCode: Int
    let message: String?
    let data: T?

    enum CodingKeys: CodingKey {
        case statusCode
        case message
        case data
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
        message = (try? container.decode(String.self, forKey: .message)) ?? ""
        data = (try? container.decode(T.self, forKey: .data)) ?? nil
    }
}
