//
//  AppFlowController.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import UIKit

/// 자동 로그인 처리 모듈
/// 로그인 상태에 따라 초기 화면(로그인, 메인탭)으로 전환
@MainActor
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

    func show(in window: UIWindow) {
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()

        checkLoginState()
    }

    private func registerAutoSignInObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkLoginState),
            name: Notification.Name.authStateChanged,
            object: nil
        )
    }

    private func goToHome() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let mainTabVC = MainTabBarController()

            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.rootViewController = mainTabVC
                },
                completion: nil
            )
        }
    }

    private func goToLogin() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let loginVC = LoginViewController()
            rootViewController = UINavigationController(rootViewController: loginVC)
        }
    }

    @objc private func checkLoginState() {
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaults.Key.isLoggedIn) == true

        if isLogin {
            goToHome()
        } else {
            goToLogin()
        }
    }
}
