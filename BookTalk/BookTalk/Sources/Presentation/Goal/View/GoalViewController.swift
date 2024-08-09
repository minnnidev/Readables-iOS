//
//  GoalViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit
import DGCharts

final class GoalViewController: BaseViewController {

    private let scrollView = UIScrollView()
    private let goalChart = BarChartView()

    private let viewModel: GoalViewModel

    init(viewModel: GoalViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    func bind() {
        viewModel.send(action: .loadGoalData(goalData: GoalModel.stubGoals))

        viewModel.goalChartData.subscribe { [weak self] entryData in
            self?.updateChartData()
        }

        viewModel.goalLabelData.subscribe { [weak self] labels in
            self?.goalChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
            self?.goalChart.xAxis.setLabelCount(labels.count, force: false)
        }
    }

    override func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "목표"

        let plusButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonDidTapped)
        )

        navigationItem.rightBarButtonItem = plusButton
    }

    override func setViews() {
        scrollView.do {
            $0.backgroundColor = .clear
        }

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
        [scrollView].forEach {
            view.addSubview($0)
        }

        [goalChart].forEach {
            scrollView.addSubview($0)
        }

        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        goalChart.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
        }
    }

    @objc private func addButtonDidTapped() {
        // TODO: 목표 추가로 이동
    }
}

extension GoalViewController {

    private func updateChartData() {
        let barChartdataSet = BarChartDataSet(entries: viewModel.goalChartData.value)
        barChartdataSet.setColor(.accentOrange)
        barChartdataSet.drawValuesEnabled = false

        let barChartData = BarChartData(dataSet: barChartdataSet)
        goalChart.data = barChartData
    }
}
