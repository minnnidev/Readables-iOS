//
//  DetailGoalViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/10/24.
//

import UIKit
import DGCharts

final class DetailGoalViewController: BaseViewController {

    // MARK: - Properties

    private let scrollView = UIScrollView()
    private let bookImageView = UIImageView()
    private let bookTitlelabel = UILabel()
    private let bookAuthorLabel = UILabel()
    private let bookPublisherLabel = UILabel()
    private let bookPublishedDate = UILabel()
    private let startReadingDate = UILabel()
    private let archiveView = UIView()
    private let todayDateLabel = UILabel()
    private let goalChart = BarChartView()

    private let viewModel: DetailGoalViewModel

    // MARK: - Initializer

    init(viewModel: DetailGoalViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    // MARK: - Helpers

    private func bind() {
        viewModel.send(action: .loadGoalData(goalData: GoalModel.stubGoals))

        viewModel.goalChartData.subscribe { [weak self] entryData in
            self?.updateChartData()
        }

        viewModel.goalLabelData.subscribe { [weak self] labels in
            self?.goalChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
            self?.goalChart.xAxis.setLabelCount(labels.count, force: false)
        }
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "목표 상세"
        navigationItem.largeTitleDisplayMode = .never
    }

    override func setViews() {
        view.backgroundColor = .white

        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }

        bookImageView.do {
            $0.backgroundColor = .gray100
        }

        [
            bookTitlelabel, bookAuthorLabel, bookPublisherLabel,
            bookPublishedDate, startReadingDate
        ].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 15, weight: .medium)
            $0.text = "책 정보"
        }

        archiveView.do {
            $0.backgroundColor = UIColor(hex: 0xF6F7CD)
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
            $0.highlightPerTapEnabled = false
        }
    }

    override func setConstraints() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [
            bookImageView, bookTitlelabel, bookAuthorLabel, bookPublisherLabel,
            bookPublishedDate, startReadingDate, archiveView, goalChart
        ].forEach {
            scrollView.addSubview($0)
        }

        [].forEach {
            archiveView.addSubview($0)
        }

        bookImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }

        bookTitlelabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView).offset(20)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(12)
        }

        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitlelabel.snp.bottom)
            $0.leading.equalTo(bookTitlelabel)
        }

        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookAuthorLabel.snp.bottom)
            $0.leading.equalTo(bookTitlelabel)
        }

        bookPublishedDate.snp.makeConstraints {
            $0.top.equalTo(bookPublisherLabel.snp.bottom)
            $0.leading.equalTo(bookTitlelabel)
        }

        startReadingDate.snp.makeConstraints {
            $0.top.equalTo(bookPublishedDate.snp.bottom).offset(12)
            $0.leading.equalTo(bookTitlelabel)
        }

        archiveView.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }

        goalChart.snp.makeConstraints {
            $0.top.equalTo(archiveView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension DetailGoalViewController {

    private func updateChartData() {
        let barChartdataSet = BarChartDataSet(entries: viewModel.goalChartData.value)
        barChartdataSet.setColor(.init(hex: 0xE7D001))
        barChartdataSet.drawValuesEnabled = false

        let barChartData = BarChartData(dataSet: barChartdataSet)
        goalChart.data = barChartData
    }
}
