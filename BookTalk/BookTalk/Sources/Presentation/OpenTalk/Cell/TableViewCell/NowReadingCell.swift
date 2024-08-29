//
//  NowReadingCell.swift
//  BookTalk
//
//  Created by 김민 on 8/4/24.
//

import UIKit

final class NowReadingCell: BaseTableViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()
    private let nowReadingPeopleTableView = UITableView()

    private var users: [GoalUserModel]?

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setDelegate()
        registerCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(with goalUsers: [GoalUserModel]) {
        titleLabel.text = "현재 \(goalUsers.count)명이 이 책을 읽고 있어요!"
        users = goalUsers

        updateEmptyState()
        nowReadingPeopleTableView.reloadData()
    }

    private func updateEmptyState() {
        if let users = users, users.isEmpty {
            nowReadingPeopleTableView.setEmptyMessage("목표를 추가해 같이 읽어봐요.")
        } else {
            nowReadingPeopleTableView.restore()
        }
    }

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        contentView.backgroundColor = .white

        titleLabel.do {
            $0.font = .systemFont(ofSize: 19, weight: .semibold)
            $0.text = "현재 17명이 이 책을 읽고 있어요!"
        }

        nowReadingPeopleTableView.do {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.contentInset = .init()
            $0.separatorStyle = .none
        }
    }

    override func setConstraints() {
        [titleLabel, nowReadingPeopleTableView].forEach {
            contentView.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        nowReadingPeopleTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(250)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        nowReadingPeopleTableView.dataSource = self
        nowReadingPeopleTableView.delegate = self
    }

    private func registerCell() {
        nowReadingPeopleTableView.register(
            ReadingPeopleCell.self,
            forCellReuseIdentifier: ReadingPeopleCell.identifier
        )
    }
}

extension NowReadingCell: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return min(users?.count ?? 0, 5)
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReadingPeopleCell.identifier,
            for: indexPath
        ) as? ReadingPeopleCell else { return UITableViewCell() }

        cell.bind(with: users?[indexPath.row])

        return cell
    }
}

extension NowReadingCell: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50
    }
}
