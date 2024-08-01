//
//  RecommendationBookCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

import SnapKit
import Then

final class RecommendationBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var basicBookInfo: [BasicBookInfo] = []
    private var detailBookInfo: [DetailBookInfo] = []
    private let collectionView: UICollectionView
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 110, height: 160)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind(_ basicBookInfo: [BasicBookInfo]) {
        self.basicBookInfo = basicBookInfo
        collectionView.reloadData()
    }
    
    // MARK: - Set UI
    
    private func setViews() {
        collectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(
                RecommendationBookCollectionCell.self,
                forCellWithReuseIdentifier: "RecommendationBookCollectionCell"
            )
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendationBookCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return basicBookInfo.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecommendationBookCollectionCell",
            for: indexPath
        ) as? RecommendationBookCollectionCell else {
            return UICollectionViewCell()
        }
        let basicInfo = basicBookInfo[indexPath.item]
        cell.bind(basicInfo)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RecommendationBookCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = basicBookInfo[indexPath.item]
        print("DEBUG: Selected \"\(selectedBook)\"")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendationBookCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 110, height: collectionView.frame.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }
}
