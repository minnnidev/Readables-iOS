//
//  RegistrationViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/22/24.
//

import UIKit

enum Gender {
    case male, female
}

struct RegistrationViewModel {
    
    // MARK: - Inputs
    
    let nickname = Observable<String>("")
    let selectedGender = Observable<Gender?>(nil)
    let birthDate = Observable<Date?>(nil)
    let isFormValid = Observable<Bool>(false)
    
    // MARK: - Actions
    
    func updateNickname(_ text: String) {
        nickname.value = text
        validateForm()
    }
    
    func updateGender(_ gender: Gender) {
        selectedGender.value = gender
        validateForm()
    }
    
    func updateBirthDate(_ date: Date?) {
        birthDate.value = date
        validateForm()
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
