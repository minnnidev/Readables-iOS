//
//  GoalViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

final class GoalViewController: BaseViewController {

    // MARK: - Properties

    private let goalTableView = UITableView()

    private let viewModel: GoalViewModel

    // MARK: - Initializer

    init(viewModel: GoalViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setDelegate()
        bind()
    }

    // MARK: - UI Setup

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
        view.backgroundColor = .white

        goalTableView.do { 
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.separatorInset = .init()
            $0.separatorStyle = .none
        }
    }

    override func setConstraints() {
        view.addSubview(goalTableView)

        goalTableView.snp.makeConstraints { 
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func bind() {
        viewModel.send(action: .loadGoalData(goalData: GoalModel.stubGoals))

        viewModel.goalChartData.subscribe { [weak self] _ in
            self?.goalTableView.reloadData()
        }

        viewModel.goalLabelData.subscribe { [weak self] _ in
            self?.goalTableView.reloadData()
        }
    }

    private func registerCell() {
        goalTableView.register(
            GoalChartCell.self,
            forCellReuseIdentifier: GoalChartCell.identifier
        )

        goalTableView.register(
            CategoryBookCell.self,
            forCellReuseIdentifier: CategoryBookCell.identifier
        )
    }

    private func setDelegate() {
        goalTableView.dataSource = self
        goalTableView.delegate = self
    }

    // MARK: - Actions

    @objc private func addButtonDidTapped() {
        // TODO: 목표 추가로 이동
    }
}

extension GoalViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return GoalSectionType.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.goalSections[indexPath.section]

        switch sectionType {
        case .chart:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GoalChartCell.identifier,
                for: indexPath
            ) as? GoalChartCell else { return UITableViewCell() }

            cell.bind(
                values: .init(entries: viewModel.goalChartData.value),
                labels: viewModel.goalLabelData.value
            )

            return cell

        case .progressGoal, .completedGoal:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryBookCell.identifier,
                for: indexPath
            ) as? CategoryBookCell else { return UITableViewCell() }

            if sectionType == .progressGoal {
                cell.bind(
                    .init(headerTitle: "애벌래 님이 진행중인 목표 ⚡", books: [])
                )
            } else if sectionType == .completedGoal {
                cell.bind(
                    .init(headerTitle: "애벌래 님이 완료한 목표 📚", books: [])
                )
            }

            return cell
        }
    }
}

extension GoalViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
