//
//  SecondCategoryViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

class SecondCategoryViewController: BaseViewController {

    private let secondCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    private let viewModel = SecondCategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        registerCell()
    }

    override func setNavigationBar() {
        navigationItem.title = "철학"
        navigationItem.largeTitleDisplayMode = .never
    }

    override func setViews() {
        view.backgroundColor = .white

        secondCategoryCollectionView.do {
            $0.collectionViewLayout = createCompositionalLayout()
            $0.backgroundColor = .clear
        }
    }

    override func setConstraints() {
        [secondCategoryCollectionView].forEach {
            view.addSubview($0)
        }

        secondCategoryCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func setCollectionView() {
        secondCategoryCollectionView.dataSource = self
    }

    private func registerCell() {
        secondCategoryCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        secondCategoryCollectionView.register(CategoryTitleCell.self, forCellWithReuseIdentifier: CategoryTitleCell.identifier)
    }
}

extension SecondCategoryViewController {

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env -> NSCollectionLayoutSection? in

            switch self?.viewModel.sections[section] {
            case .banner:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section

            case .category:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(60)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section

            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(200)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 60, leading: 0, bottom: 30, trailing: 0)

                return section
            }
        }

        return layout
    }
}

extension SecondCategoryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else { return UICollectionViewCell() }

            return cell

        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTitleCell.identifier, for: indexPath) as? CategoryTitleCell else { return UICollectionViewCell() }

            return cell

        default:
            return UICollectionViewCell()
        }
    }
}
