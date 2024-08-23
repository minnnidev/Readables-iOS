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

    static func getUserLibraries() async throws -> [LibraryInfo] {
        let result: UserLibraryResponseDTO = try await NetworkService.shared.request(
            target: UserTarget.getUserLibraries
        )

        return result.libraries.map { $0.toModel() }
    }

    static func editUserLibraries(newLibraries: [LibraryInfo]) async throws -> [LibraryInfo] {
        let body: EditLibraryRequestDTO = .init(
            libraries: newLibraries.map {
            .init(code: $0.code, name: $0.name)
        }
        )

        let result: UserLibraryResponseDTO = try await NetworkService.shared.request(
            target: UserTarget.editUserLibraries(body: body)
        )

        return result.libraries.map { $0.toModel() }
    }
}
