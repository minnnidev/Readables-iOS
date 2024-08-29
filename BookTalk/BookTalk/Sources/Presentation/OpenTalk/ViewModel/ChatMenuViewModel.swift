//
//  ChatMenuViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import Combine
import Foundation

final class ChatMenuViewModel {

    private(set) var progressingUsers = Observable<[GoalUserModel]>([])
    private(set) var completedUsers = Observable<[GoalUserModel]>([])
    private(set) var myProgress = Observable<MyGoalModel?>(nil)
    private(set) var loadState = Observable(LoadState.initial)

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    let isbn: String

    init(isbn: String) {
        self.isbn = isbn

        bind()
    }

    private func bind() {
        NotificationCenter.default.publisher(for: .progressChanged)
            .sink { [weak self] _ in
                guard let self = self else { return }

                send(action: .loadChatMenu(isbn: isbn))
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    enum Action {
        case loadChatMenu(isbn: String)
    }

    func send(action: Action) {
        switch action {
        case let .loadChatMenu(isbn):
            loadState.value = .loading

            Task {
                do {
                    let progressingUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: false)
                    let completedUsers = try await GoalService.getGoalUserState(of: isbn, isFinished: true)
                    let myProgress = try await GoalService.getMyProgress(of: isbn)

                    await MainActor.run {
                        self.progressingUsers.value = progressingUsers
                        self.completedUsers.value = completedUsers
                        self.myProgress.value = myProgress

                        loadState.value = .completed
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }
        }
    }
}
