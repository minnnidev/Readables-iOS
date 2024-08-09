//
//  GoalViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/9/24.
//

import Foundation
import DGCharts

final class GoalViewModel {

    enum Action {
        case loadGoalData(goalData: [GoalModel])
    }

    var goalChartData = Observable<[BarChartDataEntry]>([])
    var goalLabelData = Observable<[String]>([])

    let goalSections = GoalSectionType.allCases

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
