//
//  MyLibraryViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class MyLibraryViewController: BaseViewController {

    // MARK: - Properties

    private let descriptionLabel = UILabel()
    private let libraryTableView = UITableView()
    private let indicatorView = UIActivityIndicatorView(style: .medium)

    private let viewModel = MyLibraryViewModel()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setDelegate()
        bind()

        viewModel.send(action: .loadMyLibraries)
    }

    private func bind() {
        viewModel.myLibraries.subscribe { [weak self] _ in
            self?.libraryTableView.reloadData()
        }

        viewModel.loadState.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial:
                break

            case .loading:
                indicatorView.startAnimating()

            case .completed:
                indicatorView.stopAnimating()

                if viewModel.myLibraries.value.isEmpty {
                    libraryTableView.setEmptyMessage("등록된 내 도서관이 없습니다.")
                } else {
                    libraryTableView.restore()
                }
            }
        }
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

        descriptionLabel.do {
            $0.text = "내 도서관은 최대 3개까지 등록 가능합니다."
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .lightGray
        }

        libraryTableView.do {
            $0.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.rowHeight = UITableView.automaticDimension
        }

        indicatorView.do {
            $0.hidesWhenStopped = true
        }
    }

    override func setConstraints() {
        [descriptionLabel, libraryTableView, indicatorView].forEach {
            view.addSubview($0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }

        libraryTableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        indicatorView.snp.makeConstraints { 
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func registerCell() {
        libraryTableView.register(
            LibrarySimpleCell.self,
            forCellReuseIdentifier: LibrarySimpleCell.identifier
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

        guard !isEditing else { return }
        
        viewModel.send(action: .editMyLibraries(newLibraries: viewModel.myLibraries.value))
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
        return viewModel.myLibraries.value.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LibrarySimpleCell.identifier,
            for: indexPath
        ) as? LibrarySimpleCell else { return UITableViewCell() }

        cell.bind(with: viewModel.myLibraries.value[indexPath.row].name)
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
        viewModel.send(action: .deleteMyLibraries(index: indexPath.row))
    }
}
