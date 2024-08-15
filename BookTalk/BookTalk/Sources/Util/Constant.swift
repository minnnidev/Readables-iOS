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
