//
//  MyLibraryViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class MyLibraryViewController: BaseViewController {

    // MARK: - Properties

    private let libraryTableView = UITableView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setDelegate()
    }

    // MARK: - Set UI
    
    override func setNavigationBar() {
        navigationItem.title = "내 도서관 관리"

        let addButton = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addLibraryButtonDidTapped)
        )

        let editButton = UIBarButtonItem(
            title: "삭제",
            style: .plain,
            target: self,
            action: #selector(editButtonDidTapped)
        )

        navigationItem.rightBarButtonItems = [editButton, addButton]
    }
    
    override func setViews() {
        view.backgroundColor = .white

        libraryTableView.do {
            $0.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
            $0.backgroundColor = .clear
            $0.rowHeight = UITableView.automaticDimension
        }
    }

    override func setConstraints() {
        view.addSubview(libraryTableView)

        libraryTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func registerCell() {
        libraryTableView.register(
            LibraryCell.self,
            forCellReuseIdentifier: LibraryCell.identifier
        )
    }

    private func setDelegate() {
        libraryTableView.dataSource = self
        libraryTableView.delegate = self
    }

    // MARK: - Actions

    @objc private func editButtonDidTapped() {
        let isEditing = !libraryTableView.isEditing
        libraryTableView.setEditing(isEditing, animated: true)

        navigationItem.rightBarButtonItem?.title = isEditing ? "완료" : "삭제"
    }

    @objc private func addLibraryButtonDidTapped() {
        let searchLibraryVC = SearchLibraryViewController()
        navigationController?.pushViewController(searchLibraryVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MyLibraryViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 3
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LibraryCell.identifier,
            for: indexPath
        ) as? LibraryCell else { return UITableViewCell() }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyLibraryViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        // TODO: 삭제하기
    }
}
