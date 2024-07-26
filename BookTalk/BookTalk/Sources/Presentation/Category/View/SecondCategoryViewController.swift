//
//  SecondCategoryViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class SecondCategoryViewController: BaseViewController {

    private let secondCategoryTableView = UITableView(frame: .zero)

    private let viewModel = SecondCategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        registerCell()
    }

    override func setNavigationBar() {
        // TODO: Navigation bar title 대주제에 맞게 수정
        navigationItem.title = "철학"
        navigationItem.largeTitleDisplayMode = .never
    }

    override func setViews() {
        view.backgroundColor = .white

        secondCategoryTableView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.separatorInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        }
    }

    override func setConstraints() {
        [secondCategoryTableView].forEach {
            view.addSubview($0)
        }

        secondCategoryTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func setCollectionView() {
        secondCategoryTableView.dataSource = self
        secondCategoryTableView.delegate = self
    }

    private func registerCell() {
        secondCategoryTableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        secondCategoryTableView.register(CategoryTitleCell.self, forCellReuseIdentifier: CategoryTitleCell.identifier)
        secondCategoryTableView.register(ShowAllBookCell.self, forCellReuseIdentifier: ShowAllBookCell.identifier)
        secondCategoryTableView.register(CategoryBookCell.self, forCellReuseIdentifier: CategoryBookCell.identifier)
    }
}

extension SecondCategoryViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]

        switch section {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else { return UITableViewCell() }

            return cell

        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTitleCell.identifier, for: indexPath) as? CategoryTitleCell else { return UITableViewCell() }

            return cell

        case .allBookButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowAllBookCell.identifier, for: indexPath) as? ShowAllBookCell else { return UITableViewCell() }

            return cell

        case .newBooks, .popularBooks:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryBookCell.identifier, for: indexPath) as? CategoryBookCell else { return UITableViewCell() }

            cell.bind(section == .newBooks ? viewModel.newBooks : viewModel.popularBooks)

            return cell
        }
    }
}

extension SecondCategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {

        case .banner:
            return 160

        case .category, .allBookButton, .newBooks, .popularBooks:
            return UITableView.automaticDimension
        }
    }
}
