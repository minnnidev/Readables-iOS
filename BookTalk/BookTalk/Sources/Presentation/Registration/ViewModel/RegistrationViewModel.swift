//
//  RegistrationViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/22/24.
//

import UIKit

struct RegistrationViewModel {
    
    let nickname = Observable<String>("")
    let selectedGender = Observable<GenderType?>(nil)
    let birthDate = Observable<Date?>(nil)
    let isFormValid = Observable<Bool>(false)
    let pushToHomeView = Observable<Bool>(false)

    // MARK: - Actions
    
    func updateNickname(_ text: String) {
        nickname.value = text
        validateForm()
    }
    
    func updateGender(_ gender: GenderType) {
        selectedGender.value = gender
        validateForm()
    }
    
    func updateBirthDate(_ date: Date?) {
        birthDate.value = date
        validateForm()
    }

    func registerUserInfo(
        nickname: String,
        gender: GenderType,
        birth: String
    ) {
        Task {
            do {
                let newUserInfo = try await UserService.editUserInfo(
                    nickname: nickname,
                    gender: gender,
                    birthDate: birth
                )

                UserData.shared.saveUser(newUserInfo)

                await MainActor.run {
                    UserDefaults.standard.set(true, forKey: UserDefaults.Key.isLoggedIn)
                    NotificationCenter.default.post(
                        name: Notification.Name.authStateChanged,
                        object: nil
                    )
                }
            } catch let error as NetworkError {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Helpers
    
    private func validateForm() {
        isFormValid.value =
            isNicknameValid() && selectedGender.value != nil && birthDate.value != nil
    }
    
    private func isNicknameValid() -> Bool {
        guard !nickname.value.isEmpty else { return false }
        
        if isKorean(nickname.value) {
            return nickname.value.count >= 2
        } else {
            return nickname.value.count >= 3
        }
    }
    
    private func isKorean(_ text: String) -> Bool {
        let koreanRegex = "^[가-힣]*$"
        let koreanPredicate = NSPredicate(format: "SELF MATCHES %@", koreanRegex)
        return koreanPredicate.evaluate(with: text)
    }
}
