//
//  OpenTalkViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

final class OpenTalkViewModel {

    // MARK: - Properties

    var selectedPageType = OpenTalkPageType.hot
    var hotOpenTalks = [OpenTalkModel]()
    var favoriteOpenTalks = [OpenTalkModel]()
    var openTalks = Observable<[OpenTalkModel]>([])

    // MARK: - Helpers

    enum Action {
        case setPageType(_ pageType: OpenTalkPageType)
        case loadOpenTalks
    }

    func send(action: Action) {
        switch action {
        case let .setPageType(pageType):
            switch pageType {
            case .hot:
                openTalks.value = hotOpenTalks
            case .liked:
                openTalks.value = favoriteOpenTalks
            }

        case .loadOpenTalks:
            // TODO: api 호출
            hotOpenTalks = [.stubOpenTalk1]
            favoriteOpenTalks = [.stubOpenTalk1, .stubOpenTalk2]

            openTalks.value = hotOpenTalks
        }
    }
}
