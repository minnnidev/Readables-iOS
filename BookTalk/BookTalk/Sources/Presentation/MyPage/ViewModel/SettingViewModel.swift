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
            // TODO: 로그아웃 api
            return

        case .withdraw:
            // TODO: 탈퇴 api
            return
        }
    }
}
