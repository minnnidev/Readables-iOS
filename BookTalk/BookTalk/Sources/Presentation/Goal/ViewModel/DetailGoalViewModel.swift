//
//  DetailGoalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/10/24.
//

import Foundation
import DGCharts

final class DetailGoalViewModel {

    enum Action {
        case loadGoalData(goalData: [GoalModel])
    }

    var goalChartData = Observable<[BarChartDataEntry]>([])
    var goalLabelData = Observable<[String]>([])

    func send(action: Action) {

        switch action {
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