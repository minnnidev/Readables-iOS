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
    var isLoading = Observable(true)

    // MARK: - Helpers

    enum Action {
        case setPageType(_ pageType: OpenTalkPageType)
        case loadOpenTalks(_ pageType: OpenTalkPageType)
    }

    func send(action: Action) {
        switch action {
        case let .setPageType(selectedPage):
            selectedPageType = selectedPage
            setOpenTalks(of: selectedPage)

        case let .loadOpenTalks(selectedPage):
            isLoading.value = true
            openTalks.value.removeAll()

            Task {
                do {
                    let result = try await OpenTalkService.getOpenTalkMainList()

                    await MainActor.run {
                        hotOpenTalks = result.hotList
                        favoriteOpenTalks = result.favoriteList

                        setOpenTalks(of: selectedPage)
                        isLoading.value = false
                    }
                    
                } catch let error as NetworkError {
                    isLoading.value = false
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setOpenTalks(of selectedPage: OpenTalkPageType) {
        switch selectedPage {
        case .hot:
            openTalks.value = hotOpenTalks
        case .liked:
            openTalks.value = favoriteOpenTalks
        }
    }
}
