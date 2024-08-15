//
//  SettingViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import UIKit

final class SettingViewController: BaseViewController {

    // MARK: - Properties

    private let settingTableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "환경 설정"
    }

    override func setViews() {
        view.backgroundColor = .white

        settingTableView.do {
            $0.backgroundColor = .yellow
            $0.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override func setConstraints() {
        [settingTableView].forEach {
            view.addSubview($0)
        }

        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }

    private func registerCell() {
        settingTableView.register(
            SettingCell.self,
            forCellReuseIdentifier: SettingCell.identifier
        )
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 4
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingCell.identifier,
            for: indexPath
        ) as? SettingCell else { return UITableViewCell() }

        return cell
    }
}

extension SettingViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50
    }
}
