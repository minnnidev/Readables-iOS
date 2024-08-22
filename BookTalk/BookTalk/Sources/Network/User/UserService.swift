//
//  UserService.swift
//  BookTalk
//
//  Created by 김민 on 8/22/24.
//

import Foundation

struct UserService {

    static func editUserInfo(
        nickname: String,
        gender: GenderType,
        birthDate: String
    ) async throws -> EditUserInfoResponseDTO {
        let body: EditUserInfoRequestDTO = .init(
            nickname: nickname,
            gender: gender.rawValue,
            birthDate: birthDate
        )

        let result: EditUserInfoResponseDTO = try await NetworkService.shared.request(target: UserTarget.editUserInfo(body: body))

        return result
    }

    static func getFavoriteBooks() async throws -> [Book] {
        let result: UserInfoResponseDTO = try await NetworkService.shared.request(
            target: UserTarget.getUserInfo
        )

        return result.dibs.map { $0.toModel() }
    }
}
