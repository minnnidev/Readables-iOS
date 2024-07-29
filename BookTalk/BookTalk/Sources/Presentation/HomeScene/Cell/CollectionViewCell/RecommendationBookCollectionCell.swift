//
//  RecommendationBookCollectionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

import SnapKit
import Then

final class RecommendationBookCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind(with book: HomeBooks) {
        imageView.image = UIImage(named: "\(book.coverImageURL)")
        titleLabel.text = book.title
    }
}

// MARK: - UI Setup

private extension RecommendationBookCollectionCell {
    
    func setupUI() {
        contentView.addSubview(imageView)
        
        configureImageView()
        setupConstraints()
    }
    
    func configureImageView() {
        imageView.do {
            $0.backgroundColor = .gray100
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.top.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}
