//
//  LoginViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Interactions
    
    struct Input {
        let loginButtonTapped: (LoginType) -> Void
    }
    
    struct Output {
        let onboardingMessage: Observable<String>
        let progressUpdate: Observable<(Int, Float)>
        let pushToRegister: Observable<Bool>
        let loadState: Observable<LoadState>
    }
    
    // MARK: - Properties

    private var pushToRegisterOB = Observable(false)
    private var loadStateOb = Observable(LoadState.initial)

    private let oauthManager = OAuthManager()

    let onboardingMessageManager: OnboardingManager
    
    lazy var input: Input = { bindInput() }()
    lazy var output: Output = { transform() }()


    // MARK: - Initializer
    
    init(onboardingMessageManager:
         OnboardingManager = OnboardingManager(
            messages: [
                "저희와 함께 마음에 드는 책을 찾아봐요!",
                "오픈톡에서 책을 주제로 대화해보세요!",
                "그래프를 통해 독서 기록을 한눈에 확인해보세요!"
            ],
            durations: [3.0, 3.0, 3.0]
         )
    ) {
        self.onboardingMessageManager = onboardingMessageManager
        setupBindings()

        onboardingMessageManager.startRotation()
    }
    
    // MARK: - Helpers
    
    private func bindInput() -> Input {
        return Input { [weak self] type in
            self?.handleLogin(type: type)
        }
    }
    
    private func transform() -> Output {
        return Output(
            onboardingMessage: Observable(""),
            progressUpdate: Observable((0, 1.0)),
            pushToRegister: pushToRegisterOB, 
            loadState: loadStateOb
        )
    }
    
    private func setupBindings() {
        onboardingMessageManager.messageUpdate = { [weak self] message in
            self?.output.onboardingMessage.value = message
        }
        onboardingMessageManager.progressUpdate = { [weak self] index, progress in
            self?.output.progressUpdate.value = (index, progress)
        }
    }
    
    private func handleLogin(type: LoginType) {
        switch type {
        case .apple:
            oauthManager.loginWithApple { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(credential):
                    loadStateOb.value = .loading

                    Task { [weak self] in
                        guard let self = self else { return }

                        do {
                            if let idTokenData = credential.identityToken,
                               let idTokenStr = String(data: idTokenData, encoding: .utf8) {

                                let isNewUser = try await AuthService.loginWithApple(idToken: idTokenStr)

                                await setAppFlow(with: isNewUser)
                                loadStateOb.value = .completed
                            } else {
                                print("idToken 변환 실패")
                                loadStateOb.value = .completed
                            }
                        } catch let error as NetworkError {
                            print(error.localizedDescription)
                            loadStateOb.value = .completed
                        }
                    }

                case let .failure(error):
                    print(error.localizedDescription)
                }
            }

        case .kakao:
            oauthManager.loginWithKakao { [weak self] result in
                guard let self = self else { return }

                switch result {
                case let .success(idToken):
                    loadStateOb.value = .loading

                    Task { [weak self] in
                        guard let self = self else { return }

                        do {
                            let isNewUser = try await AuthService.loginWithkakao(idToken: idToken)

                            await setAppFlow(with: isNewUser)
                            loadStateOb.value = .completed

                        } catch let error as NetworkError {
                            print(error.localizedDescription)
                            loadStateOb.value = .completed
                        }
                    }
                case let .failure(error):
                    print("Kakao idToken 발급 불가 \(error.localizedDescription)")
                }
            }
        }
    }

    /// 신규 회원인지 여부에 따른 App flow 조정 메서드
    /// 1. 신규회원이면 입력폼으로 이동
    /// 2. 신규회원이 아닐 경우
    ///     - 유저 정보가 존재하면 홈으로
    ///     - 유저 정보가 존재하지 않으면 입력폼으로
    @MainActor
    private func setAppFlow(with isNewUser: Bool) async {
        if isNewUser {
            pushToRegisterOB.value.toggle()
        } else {
            if await isUserInfoExist() {
                UserDefaults.standard.set(true, forKey: UserDefaults.Key.isLoggedIn)
                NotificationCenter.default.post(name: .authStateChanged, object: nil)
            } else {
                pushToRegisterOB.value.toggle()
            }
        }
    }

    private func isUserInfoExist() async -> Bool {
        do {
            let userInfo = try await UserService.getUserInfo()

            return userInfo.userInfo.nickname != nil
        } catch let error as NetworkError {
            print(error.localizedDescription)
            return false
        } catch {
            return false
        }
    }

    func cleanupTimers() {
        onboardingMessageManager.stop()
    }
}
