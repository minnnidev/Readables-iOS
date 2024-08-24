//
//  OAuthManager.swift
//  BookTalk
//
//  Created by 김민 on 8/21/24.
//

import AuthenticationServices
import Foundation

import KakaoSDKUser

final class OAuthManager: NSObject {

    var appleLoginSucceed: ((ASAuthorizationAppleIDCredential) -> Void)?

    func loginWithKakao(completion: @escaping (Result<String, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let idToken = oauthToken?.idToken {
                    completion(.success(idToken))
                } else {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let idToken = oauthToken?.idToken {
                    completion(.success(idToken))
                } else {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
    }

    func loginWithApple(completion: @escaping (Result<ASAuthorizationAppleIDCredential, Error>) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self

        self.appleLoginSucceed = { credential in
            completion(.success(credential))
        }

        authorizationController.performRequests()
    }
}

extension OAuthManager: ASAuthorizationControllerDelegate {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential
                as? ASAuthorizationAppleIDCredential else { return }

        appleLoginSucceed?(credential)
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print(error.localizedDescription)
        // TODO: 애플 로그인 실패 시 에러 처리
    }
}

extension OAuthManager: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene

        return windowScene?.windows.first ?? UIWindow()
    }
}
