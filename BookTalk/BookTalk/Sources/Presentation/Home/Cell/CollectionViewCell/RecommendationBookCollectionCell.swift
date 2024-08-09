//
//  RecommendationBookCollectionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class RecommendationBookCollectionCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Bind
    
    func bind(_ basicBookInfo: BasicBookInfo) {
        imageView.image = UIImage(named: "\(basicBookInfo.coverImageURL)")
        titleLabel.text = basicBookInfo.title
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        imageView.do {
            $0.backgroundColor = .gray100
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setConstraints() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.top.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}
