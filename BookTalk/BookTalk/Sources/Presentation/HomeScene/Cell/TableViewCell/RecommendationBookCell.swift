//
//  RecommendationBookCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

import SnapKit
import Then

class RecommendationBookCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var books: [HomeBooks] = []
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind(with books: [HomeBooks]) {
        self.books = books
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendationBookCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return books.count
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
        cell.bind(with: books[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RecommendationBookCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookTitle = books[indexPath.item].title
        print("DEBUG: Selected \"\(bookTitle)\"")
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

// MARK: - UI Setup

private extension RecommendationBookCell {
    
    func setupUI() {
        contentView.addSubview(collectionView)
        
        configureCollectionView()
        setupConstraints()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            RecommendationBookCollectionCell.self,
            forCellWithReuseIdentifier: "RecommendationBookCollectionCell"
        )
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
