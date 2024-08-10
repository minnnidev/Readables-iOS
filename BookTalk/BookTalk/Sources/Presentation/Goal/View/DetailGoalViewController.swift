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
    private let contentView = UIView()
    private let bookNameLabel = UILabel()
    private let bookImageView = UIImageView()
    private let bookTitlelabel = UILabel()
    private let bookAuthorLabel = UILabel()
    private let bookPublisherLabel = UILabel()
    private let bookPublishedDate = UILabel()
    private let startReadingDate = UILabel()
    private let archiveView = UIView()
    private let archiveLabel = UILabel()
    private let todayDateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let startPageTextField = UITextField()
    private let startTitleLabel = UILabel()
    private let endPageTextField = UITextField()
    private let endTitleLabel = UILabel()
    private let addReadPageButton = UIButton()
    private let goalChartLabel = UILabel()
    private let goalChart = BarChartView()
    private let firstSeparatorLine = UIView()
    private let secondSeparatorLine = UIView()

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

        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(menuButtonDidTapped)
        )

        navigationItem.rightBarButtonItem = menuButton
    }

    override func setViews() {
        view.backgroundColor = .white

        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
        }

        bookNameLabel.do {
            $0.text = "나미야 잡화점의 기적"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }

        archiveLabel.do {
            $0.text = "오늘 이만큼 읽었어요 📚"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }

        goalChartLabel.do {
            $0.text = "지난 일주일동안의 기록 📆"
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }

        bookImageView.do {
            $0.backgroundColor = .gray100
        }

        [
            bookTitlelabel, bookAuthorLabel, bookPublisherLabel,
            bookPublishedDate, startReadingDate
        ].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.text = "책 정보"
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
            $0.doubleTapToZoomEnabled = false
        }

        datePicker.do {
            $0.preferredDatePickerStyle = .automatic
            $0.datePickerMode = .date
            $0.locale = Locale(identifier: "ko-KR")
            $0.timeZone = .autoupdatingCurrent
        }

        [startPageTextField, endPageTextField].forEach{
            $0.backgroundColor = .clear
            $0.keyboardType = .numberPad
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5
        }

        startTitleLabel.do {
            $0.text = "부터"
            $0.font = .systemFont(ofSize: 15)
        }

        endPageTextField.do {
            $0.backgroundColor = .clear
            $0.keyboardType = .numberPad
            $0.borderStyle = .roundedRect
        }

        endTitleLabel.do {
            $0.text = "까지"
            $0.font = .systemFont(ofSize: 15)
        }

        addReadPageButton.do { 
            $0.backgroundColor = .black
            $0.setTitle("기록 추가하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
        }

        [firstSeparatorLine, secondSeparatorLine].forEach {
            $0.backgroundColor = .gray100
        }
    }

    override func setConstraints() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }

        [
            bookNameLabel, bookImageView, bookTitlelabel, bookAuthorLabel, bookPublisherLabel,
            bookPublishedDate, startReadingDate, archiveView, goalChart, datePicker,
            startPageTextField, startTitleLabel, endPageTextField, endTitleLabel, addReadPageButton,
            goalChartLabel, archiveLabel, firstSeparatorLine, secondSeparatorLine
        ].forEach {
            contentView.addSubview($0)
        }

        bookNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        bookImageView.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }

        bookTitlelabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView).offset(12)
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

        firstSeparatorLine.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }

        archiveLabel.snp.makeConstraints {
            $0.top.equalTo(firstSeparatorLine.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        datePicker.snp.makeConstraints {
            $0.top.equalTo(archiveLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        startPageTextField.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(12)
            $0.leading.equalTo(datePicker)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }

        startTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(startPageTextField)
            $0.leading.equalTo(startPageTextField.snp.trailing).offset(8)
        }

        endPageTextField.snp.makeConstraints {
            $0.centerY.equalTo(startPageTextField)
            $0.leading.equalTo(startTitleLabel.snp.trailing).offset(24)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }

        endTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(startPageTextField)
            $0.leading.equalTo(endPageTextField.snp.trailing).offset(8)
        }

        addReadPageButton.snp.makeConstraints {
            $0.top.equalTo(startPageTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }

        secondSeparatorLine.snp.makeConstraints {
            $0.top.equalTo(addReadPageButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }

        goalChartLabel.snp.makeConstraints {
            $0.top.equalTo(secondSeparatorLine.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }

        goalChart.snp.makeConstraints {
            $0.top.equalTo(goalChartLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    // MARK: - Actions

    @objc private func menuButtonDidTapped() {
        let alertVC = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let completedAction = UIAlertAction(
            title: "목표 완료",
            style: .default) { [weak self] _ in
                self?.goalDeleteButtonDidTapped()
            }

        let deleteAction = UIAlertAction(
            title: "목표 삭제",
            style: .default) { [weak self] _ in
                self?.goalCompletedButtonDidTapped()
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        [completedAction, deleteAction, cancelAction].forEach {
            alertVC.addAction($0)
        }

        present(alertVC, animated: true)
    }

    private func goalDeleteButtonDidTapped() {
        // TODO: 목표 삭제 action
    }

    private func goalCompletedButtonDidTapped() {
        // TODO: 목표 완료 action
    }

}

extension DetailGoalViewController {

    private func updateChartData() {
        let barChartdataSet = BarChartDataSet(entries: viewModel.goalChartData.value)
        barChartdataSet.setColor(.accentOrange)
        barChartdataSet.drawValuesEnabled = false

        let barChartData = BarChartData(dataSet: barChartdataSet)
        goalChart.data = barChartData
    }
}
