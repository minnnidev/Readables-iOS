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
    private(set) var createGoalSucceed = Observable(false)

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    let isbn: String
    var createdGoalId: Int?

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
        case addGoal(isbn: String, totalPage: String)
    }

    func send(action: Action) {
        switch action {
        case let .loadChatMenu(isbn):
            loadChatMenu(isbn: isbn)

        case let .addGoal(isbn, totalPage):
            Task {
                do {
                    let response = try await GoalService.createGoal(with: isbn, totalPage: Int(totalPage)!)


                    NotificationCenter.default.post(name: .goalChanged, object: nil)
                    createdGoalId = response.goalId
                    createGoalSucceed.value = true

                    loadChatMenu(isbn: isbn)

                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func loadChatMenu(isbn: String) {
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
