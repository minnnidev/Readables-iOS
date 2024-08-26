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
    var hotOpenTalks = Observable<[OpenTalkBookModel]>([])
    var favoriteOpenTalks = Observable<[OpenTalkBookModel]>([])
    var isLoading = Observable(true)

    // MARK: - Helpers

    enum Action {
        case setPageType(_ pageType: OpenTalkPageType)
    }

    func send(action: Action) {
        switch action {
        case let .setPageType(selectedPage):
            selectedPageType = selectedPage

            switch selectedPage {
            case .hot:
                loadHotOpenTalk()
            case .liked:
                loadFavoriteOpenTalk()
            }
        }
    }

    private func loadHotOpenTalk() {
        isLoading.value = true

        Task {
            do {
                let result = try await OpenTalkService.getHotOpenTalkList()

                await MainActor.run {
                    hotOpenTalks.value = result
                    isLoading.value = false
                }

            } catch let error as NetworkError {
                print(error.localizedDescription)
                isLoading.value = false
            }
        }
    }

    private func loadFavoriteOpenTalk() {
        isLoading.value = true

        Task {
            do {
                let result = try await OpenTalkService.getFavoriteOpenTalkList()

                await MainActor.run {
                    favoriteOpenTalks.value = result
                    isLoading.value = false
                }

            } catch let error as NetworkError {
                print(error.localizedDescription)
                isLoading.value = false
            }
        }
    }

}
