//
//  AddBookViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import UIKit

final class AddBookViewController: BaseViewController {

    // MARK: - Properties

    private let searchBar = UISearchBar()
    private let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    // MARK: Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.titleView = searchBar
    }

    override func setViews() {
        view.backgroundColor = .white

        searchBar.do {
            $0.placeholder = "어떤 책을 읽고 계신가요?"
        }

        resultCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.showsVerticalScrollIndicator = false
        }
    }

    override func setConstraints() {
        [searchBar, resultCollectionView].forEach {
            view.addSubview($0)
        }

        resultCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
    }

    private func registerCell() {
        resultCollectionView.register(
            BookImageCell.self,
            forCellWithReuseIdentifier: BookImageCell.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource

extension AddBookViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 50
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookImageCell.identifier,
            for: indexPath
        ) as? BookImageCell else { return UICollectionViewCell() }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddBookViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (ScreenSize.width-36) / 3
        return CGSize(width: width, height: 160)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }
}
