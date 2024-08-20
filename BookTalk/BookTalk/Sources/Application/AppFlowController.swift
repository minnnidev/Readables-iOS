//
//  AppFlowController.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import UIKit

/// 자동 로그인 처리 로직
final class AppFlowController {
    static let shared = AppFlowController()

    private init() {
        registerAutoSignInObserver()
    }

    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }

    private func registerAutoSignInObserver() {

    }

    private func goToHome() {
        let mainTabVC = MainTabBarController()
        rootViewController = mainTabVC
    }

    private func goToLogin() {
        rootViewController = LoginViewController()
    }
}
