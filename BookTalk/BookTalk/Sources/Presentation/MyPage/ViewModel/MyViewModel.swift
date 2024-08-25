//
//  MyPageViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/24/24.
//

import Foundation

final class MyPageViewModel {
    private(set) var selectedTab = Observable(0)
    private(set) var userInfoOb = Observable<UserInfo?>(nil)
    private(set) var dibBooksOb = Observable<[Book]>([])
    private(set) var readBooksOb = Observable<[Book]>([])

    enum Action {
        case selectTab(index: Int)
        case loadUserInfo
    }

    func send(action: Action) {
        switch action {
        case let .selectTab(index):
            selectedTab.value = index

        case .loadUserInfo:
            Task {
                do {
                    let userInfo = try await UserService.getUserInfo()
                    userInfoOb.value = userInfo
                    dibBooksOb.value = userInfo.dibs
                    readBooksOb.value = userInfo.readBooks

                    // TODO: 읽은 책 추가

                } catch let error as NetworkError {
                   
                }
            }
        }
    }
}
