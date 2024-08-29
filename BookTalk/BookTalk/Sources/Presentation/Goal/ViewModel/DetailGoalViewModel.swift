//
//  DetailGoalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/10/24.
//

import Foundation
import DGCharts

final class DetailGoalViewModel {

    private(set) var goalChartData = Observable<[BarChartDataEntry]>([])
    private(set) var goalLabelData = Observable<[String]>([])
    private(set) var goalDetail = Observable<GoalDetailModel?>(nil)
    private(set) var loadState = Observable(LoadState.initial)
    private(set) var deleteSucceed = Observable(false)
    private(set) var completeSucced = Observable(false)
    private(set) var recordSucceed = Observable(false)
    private(set) var isAddButtonEnabled = Observable(false)

    var endPage: String = "" {
        didSet {
            validatePageNumbers()
        }
    }

    let goalId: Int

    init(goalId: Int) {
        self.goalId = goalId
    }

    enum Action {
        case loadGoalDetail(goalId: Int)
        case loadGoalData(goalData: [GoalModel])
        case deleteGoal(goalId: Int)
        case completeGoal(goalId: Int)
        case addRecord(goalId: Int, page: Int)
    }

    func send(action: Action) {

        switch action {
        case let .loadGoalDetail(goalId):
            loadState.value = .loading

            Task {
                do {
                    let detailResult = try await GoalService.getGoalDetail(of: goalId)

                    setDetail(detailResult: detailResult)
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }
            return
            
        case let .loadGoalData(goalData):
            var entryDatas: [BarChartDataEntry] = .init()

            goalData.enumerated().forEach { idx, data in
                entryDatas.append(.init(x: Double(idx), y: Double(data.amout)))
            }

            goalChartData.value = entryDatas
            goalLabelData.value = goalData.map { $0.day }

        case let .deleteGoal(goalId):
            Task {
                do {
                    try await GoalService.deleteGoal(of: goalId)

                    NotificationCenter.default.post(name: .goalChanged, object: nil)
                    deleteSucceed.value = true
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }

        case let .completeGoal(goalId):
            Task {
                do {
                    try await GoalService.completeGoal(of: goalId)

                    NotificationCenter.default.post(name: .goalChanged, object: nil)
                    completeSucced.value = true
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }

        case let .addRecord(goalId, page):
            Task {
                do {
                    let result = try await GoalService.postTodayRecord(of: goalId, page: page)

                    setDetail(detailResult: result)
                    recordSucceed.value = true
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }
        }
    }

    private func validatePageNumbers() {
        guard let startPage = goalDetail.value?.recentPage else { return }

        if let end = Int(endPage) {
            isAddButtonEnabled.value = end > startPage
        } else {
            isAddButtonEnabled.value = false
        }
    }

    private func setDetail(detailResult: GoalDetailModel) {
        Task {
            await MainActor.run {
                let pageData = detailResult.goalModel.map { $0.amout }

                goalDetail.value = detailResult

                var entryDatas: [BarChartDataEntry] = .init()

                pageData.enumerated().forEach { idx, page in
                    entryDatas.append(.init(x: Double(idx), y: Double(page)))
                }

                goalLabelData.value = detailResult.goalModel.map { $0.day.toShortDateFormat() }
                goalChartData.value = entryDatas

                loadState.value = .completed
            }
        }
    }
}
