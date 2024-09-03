//
//  Keychain+.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

typealias TokenKey = KeychainManager.TokenKey
typealias UserKey = KeychainManager.UserKey

extension KeychainManager {

    enum TokenKey {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    enum UserKey {
        static let appleUserId = "appleUserId"
    }
}
