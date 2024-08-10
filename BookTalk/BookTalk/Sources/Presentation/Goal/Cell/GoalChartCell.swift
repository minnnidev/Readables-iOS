//
//  GoalChartCell.swift
//  BookTalk
//
//  Created by 김민 on 8/10/24.
//

import UIKit

import DGCharts

final class GoalChartCell: BaseTableViewCell {

    // MARK: - Properties
    
    private let goalChart = BarChartView()

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        goalChart.do {
            $0.noDataText = "아직 데이터가 없습니다."
            $0.noDataFont = .systemFont(ofSize: 15)
            $0.noDataTextColor = .lightGray

            $0.xAxis.labelPosition = .bottom
            $0.xAxis.drawGridLinesEnabled = false
            $0.xAxis.drawAxisLineEnabled = false

            $0.backgroundColor = .clear
            $0.doubleTapToZoomEnabled = false
            $0.rightAxis.enabled = false
            $0.legend.enabled = false
        }
    }

    override func setConstraints() {
        contentView.addSubview(goalChart)

        goalChart.snp.makeConstraints { 
            $0.top.leading.equalToSuperview().offset(12)
            $0.height.equalTo(200)
            $0.trailing.bottom.equalToSuperview().offset(-12)
        }
    }

    func bind(values barChartDataSet: BarChartDataSet, labels: [String]) {
        barChartDataSet.setColor(.accentOrange)
        barChartDataSet.drawValuesEnabled = false

        goalChart.data = BarChartData(dataSet: barChartDataSet)
        goalChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        goalChart.xAxis.setLabelCount(labels.count, force: false)
    }
}
