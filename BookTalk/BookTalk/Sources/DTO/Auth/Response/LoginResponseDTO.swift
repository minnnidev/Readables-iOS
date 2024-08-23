//
//  LoginResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let userId: Int
    let isNewUser: Bool
    let accessToken: String
    let refreshToken: String
}
