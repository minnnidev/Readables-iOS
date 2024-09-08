//
//  AuthManager.swift
//  BookTalk
//
//  Created by 김민 on 9/8/24.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()

    private init() {}

    func initAuthState() {
        UserDefaults.standard.set(nil, forKey: UserDefaults.Key.loginType)
        UserData.shared.deleteUser()
        KeychainManager.shared.deleteAll()
    }
}
