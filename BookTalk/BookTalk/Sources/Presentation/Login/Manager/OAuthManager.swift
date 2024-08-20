//
//  OAuthManager.swift
//  BookTalk
//
//  Created by 김민 on 8/21/24.
//

import Foundation

import KakaoSDKUser

final class OAuthManager {

    func loginWithKakao() {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    _ = oauthToken
                }
            }
        }
    }
}
