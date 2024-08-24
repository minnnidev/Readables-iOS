//
//  UserData.swift
//  BookTalk
//
//  Created by 김민 on 8/24/24.
//

import Foundation

final class UserData {
    static let shared = UserData()

    private init() {}

    private let key = UserDefaults.Key.userData
    private let defaults = UserDefaults.standard

    func saveUser(_ user: UserBasicInfo) {
        do {
            let data = try JSONEncoder().encode(user)
            defaults.set(data, forKey: key)
        } catch {
            print("유저 저장 실패")
        }
    }

    func getUser() -> UserBasicInfo? {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }

        do {
            let user = try JSONDecoder().decode(UserBasicInfo.self, from: data)
            return user
        } catch {
            print("유저 정보 불러오기 실패")
            return nil
        }
    }
}
