//
//  MyViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

final class MyViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let profileInfoViewModel = ProfileInfoViewModel()
    private let myPageStickyTabViewModel = MyPageStickyTabViewModel()

    private let collectionView: UICollectionView = {
        let layout = StickyHeaderFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        return UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setDelegate()
        updateBooksCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.performWithoutAnimation {
            collectionView.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    
    @objc private func editInfoButtonDidTap() {
        let editInfoVC = EditInfoViewController()
        editInfoVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(editInfoVC, animated: true)
    }
    
    @objc private func settingButtonDidTap() {
        let viewModel = SettingViewModel()
        let settingVC = SettingViewController(viewModel: viewModel)
        settingVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    // MARK: - Bind
    
    private func updateBooksCount() {
        myPageStickyTabViewModel.updateFinishedBookCount(0)
        myPageStickyTabViewModel.updateFavoriteBookCount(0)
    }
    
    // MARK: - Set UI
    
    override func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(editInfoButtonDidTap)
        )
        
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingButtonDidTap)
        )

        navigationItem.rightBarButtonItems = [settingButton, editButton]
    }
    
    override func setViews() {
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
    }
    
    override func setConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func registerCell() {
        collectionView.do {
            $0.register(
                ProfileInfoView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ProfileInfoView.identifier
            )
            
            $0.register(
                MyPageStickyTabView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: MyPageStickyTabView.identifier
            )
            
            $0.register(
                BookImageCell.self,
                forCellWithReuseIdentifier: BookImageCell.identifier
            )
        }
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
        profileInfoViewModel.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension MyViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard section == 1 else { return 0 }
        
        let viewModelOutput = myPageStickyTabViewModel.output
        
        switch viewModelOutput.currentTabIndex.value {
        case 0: return viewModelOutput.finishedBookCount.value
        case 1: return viewModelOutput.favoriteBookCount.value
        default: return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard indexPath.section == 1 else { return UICollectionViewCell() }
        
        if myPageStickyTabViewModel.output.currentTabIndex.value == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookImageCell.identifier,
                for: indexPath
            ) as? BookImageCell else {
                return UICollectionViewCell()
            }
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.cornerRadius = 10
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookImageCell.identifier,
                for: indexPath
            ) as? BookImageCell else {
                return UICollectionViewCell()
            }
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.cornerRadius = 10
            
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                guard let profileInfoView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ProfileInfoView.identifier,
                    for: indexPath
                ) as? ProfileInfoView else {
                    return UICollectionReusableView()
                }
                
                profileInfoView.bind(profileInfoViewModel)
                
                return profileInfoView
            } else {
                guard let myPageStickyTabView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: MyPageStickyTabView.identifier,
                    for: indexPath
                ) as? MyPageStickyTabView else {
                    return UICollectionReusableView()
                }
                
                myPageStickyTabView.delegate = self
                myPageStickyTabView.bind(myPageStickyTabViewModel)
                myPageStickyTabView.setSelectedTab(
                    index: myPageStickyTabViewModel.output.currentTabIndex.value
                )
                
                return myPageStickyTabView
            }
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate

extension MyViewController: UICollectionViewDelegate {
}

// MARK: - MyPageStickyTabViewDelegate

extension MyViewController: MyPageStickyTabViewDelegate {
    
    func didSelectTab(index: Int) {
        myPageStickyTabViewModel.input.tabSelected(index)
        collectionView.reloadData()
    }
}

// MARK: - ProfileInfoViewModelDelegate

extension MyViewController: ProfileInfoViewModelDelegate {
    
    func didTapAddFinishedBookButton() {
        let viewModel = AddBookViewModel()
        let addBookVC = AddBookViewController(viewModel: viewModel)
        addBookVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addBookVC, animated: true)
    }
    
    func didTapEditLibraryButton() {
        let myLibraryVC = MyLibraryViewController()
        navigationController?.pushViewController(myLibraryVC, animated: true)
    }
}

// MARK: - UICollectionViewLayout

private extension MyViewController {
    
    static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment)
            -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: return createProfileSection()
            case 1: return createBooksSection()
            default: return nil
            }
        }
    }
    
    static func createProfileHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(270)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
    
    static func createProfileSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(270)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createProfileHeaderItem()]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        
        return section
    }
    
    static func createStickyTabHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        headerItem.pinToVisibleBounds = true
        
        return headerItem
    }
    
    static func createBooksSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createStickyTabHeaderItem()]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        section.interGroupSpacing = 10
        
        return section
    }
}
