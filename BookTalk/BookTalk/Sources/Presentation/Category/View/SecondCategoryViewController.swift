//
//  SecondCategoryViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

import SnapKit
import Then

final class SecondCategoryViewController: BaseViewController {

    // MARK: - Properties

    private let secondCategoryTableView = UITableView(frame: .zero)

    private let viewModel: SecondCategoryViewModel

    // MARK: - Initializer

    init(viewModel: SecondCategoryViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        registerCell()
        bind()
    }

    // MARK: - Helpers

    override func setNavigationBar() {
        navigationItem.title = viewModel.firstCategoryType.title
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

    private func bind() {
        viewModel.secondCategory.subscribe { [weak self] _ in
            self?.secondCategoryTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

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

            let category: Category = .init(
                firstCatgory: viewModel.firstCategoryType.title,
                secondCategory: viewModel.secondCategory.value
            )
            cell.bind(category)

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


// MARK: - UITableViewDelegate

extension SecondCategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {

        case .banner:
            return 160

        case .category, .allBookButton, .newBooks, .popularBooks:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {

        case .category:
            let viewModel = CategorySelectModalViewModel(
                firstCategory: viewModel.firstCategoryType,
                subcategory: viewModel.secondCategory.value
            )
            let modalViewController = CategorySelectModalViewController(viewModel: viewModel)

            modalViewController.modalPresentationStyle = .pageSheet
            modalViewController.delegate = self

            present(modalViewController, animated: true)

        case .allBookButton:
            let thirdCategoryViewController = ThirdCategoryViewController()
            thirdCategoryViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(thirdCategoryViewController, animated: true)

        case .banner, .newBooks, .popularBooks:
            return
        }
    }
}

// MARK: - CategorySelectModalViewControllerDelegate

extension SecondCategoryViewController: CategorySelectModalViewControllerDelegate {

    func subcategorySelected(subcategory: String) {
        viewModel.send(action: .setSubcategory(subcategory: subcategory))
    }
}
