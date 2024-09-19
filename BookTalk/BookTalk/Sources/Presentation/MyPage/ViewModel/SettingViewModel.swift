//
//  SettingViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import Foundation

final class SettingViewModel {

    enum Action {
        case logout
        case withdraw
    }

    func send(action: Action) {
        switch action {
        case .logout:
            Task {
                do {
                    try await AuthService.logout()

                    await MainActor.run {
                        NotificationCenter.default.post(
                            name: .authStateChanged,
                            object: nil
                        )
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }

        case .withdraw:
            Task {
                do {
                    try await AuthService.withdraw()

                    await MainActor.run {
                        NotificationCenter.default.post(
                            name: .authStateChanged,
                            object: nil
                        )
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
