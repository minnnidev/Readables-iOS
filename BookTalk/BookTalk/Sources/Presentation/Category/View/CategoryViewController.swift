//
//  CategoryViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit
import SnapKit
import Then

final class CategoryViewController: BaseViewController {

    private let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setCollectionView()
    }

    override func setNavigationBar() {
        navigationItem.title = "카테고리"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func setViews() {
        categoryCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()

            $0.collectionViewLayout = flowLayout
            $0.showsVerticalScrollIndicator = false
        }
    }

    override func setConstraints() {
        [categoryCollectionView].forEach {
            view.addSubview($0)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(35)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }

    private func registerCell() {
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

    private func setCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
}

extension CategoryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FirstCategoryType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenSize.width-40-16)/2, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
