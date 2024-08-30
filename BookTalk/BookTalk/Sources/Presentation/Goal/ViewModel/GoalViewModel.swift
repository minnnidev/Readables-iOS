//
//  GoalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/9/24.
//

import Foundation
import Combine 
import DGCharts

final class GoalViewModel {

    private(set) var goalSections = GoalSectionType.allCases
    private(set) var goalChartData = Observable<[BarChartDataEntry]>([])
    private(set) var goalLabelData = Observable<[String]>([])
    private(set) var progressingGoals = Observable<[GoalDetailModel]>([])
    private(set) var completedGoals = Observable<[GoalDetailModel]>([])
    private(set) var loadState = Observable(LoadState.initial)

    private var cancellables = Set<AnyCancellable>()

    enum Action {
        case loadGoalData(goalData: [GoalModel])
        case loadGoalPage
    }

    init() {
        bind()
    }

    private func bind() {
        NotificationCenter.default.publisher(for: .goalChanged)
            .sink { [weak self] _ in
                self?.send(action: .loadGoalPage)
            }
            .store(in: &cancellables)
    }

    func send(action: Action) {

        switch action {
        case let .loadGoalData(goalData):
            var entryDatas: [BarChartDataEntry] = .init()
            
            goalData.enumerated().forEach { idx, data in
                entryDatas.append(.init(x: Double(idx), y: Double(data.amout)))
            }

            goalChartData.value = entryDatas
            goalLabelData.value = goalData.map { $0.day }

        case .loadGoalPage:
            loadState.value = .loading

            Task {
                do {
                    let progressingGoals = try await GoalService.getUserGoal(isFinished: false)
                    let completedGoals = try await GoalService.getUserGoal(isFinished: true)
                    let weekRecord = try await GoalService.getAWeekTotal()
                    let pageData = weekRecord.map { $0.amout }

                    await MainActor.run {
                        var entryDatas: [BarChartDataEntry] = .init()

                        pageData.enumerated().forEach { idx, page in
                            entryDatas.append(.init(x: Double(idx), y: Double(page)))
                        }
                        
                        self.progressingGoals.value = progressingGoals.reversed()
                        self.completedGoals.value = completedGoals
                        
                        goalLabelData.value = weekRecord.map { $0.day.toShortDateFormat() }
                        goalChartData.value = entryDatas

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
