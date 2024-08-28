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

    let goalId: Int

    // TODO: 수정 / 현재 임의로 넣어둠
    init(goalId: Int = 3) {
        self.goalId = goalId
    }

    enum Action {
        case loadGoalDetail(goalId: Int)
        case loadGoalData(goalData: [GoalModel])
    }

    func send(action: Action) {

        switch action {
        case let .loadGoalDetail(goalId):
            loadState.value = .loading

            Task {
                do {
                    let detailResult = try await GoalService.getGoalDetail(of: goalId)

                    await MainActor.run {
                        goalDetail.value = detailResult
                        loadState.value = .completed
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
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
        }
    }
}
