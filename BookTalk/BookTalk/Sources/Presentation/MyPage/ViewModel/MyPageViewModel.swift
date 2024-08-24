//
//  MyPageViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/24/24.
//

import Foundation

final class MyPageViewModel {
    private(set) var selectedTab = Observable(0)

    enum Action {
        case selectTab(index: Int)
    }

    func send(action: Action) {
        switch action {
        case let .selectTab(index):
            selectedTab.value = index
        }
    }
}
