//
//  Constant.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

typealias ScreenSize = Constant.ScreenSize

enum Constant { }

extension Constant {

    struct ScreenSize {
        static let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        static let width = windowScene?.screen.bounds.width ?? 0
        static let height = windowScene?.screen.bounds.height ?? 0
    }
}

extension Constant {

    static var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "v.\(version)"
        }
        return "v.0.0"
    }
}

extension Constant {

    static var kakaoKey: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("plist 파일 찾을 수 없음")
        }

        guard let value = plistDict.object(forKey: "KakaoNativeAppKey") as? String else {
            fatalError("key값 찾을 수 없음")
        }

        return value
    }
}
