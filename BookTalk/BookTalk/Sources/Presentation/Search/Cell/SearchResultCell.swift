//
//  SearchResultCell.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import UIKit

protocol SearchResultCellDelegate: AnyObject {
    
    func searchResultCell(_ cell: SearchResultCell, didSelectBook book: DetailBookInfo)
}

final class SearchResultCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SearchResultCellDelegate?
    
    private var detailBookInfo: DetailBookInfo?
    private let coverImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publicationDateLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    private let availabilityLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    private var isFavorite: Bool = false
    
    // MARK: - Actions
    
    @objc private func favoriteButtonDidTap() {
        isFavorite.toggle()
        updateFavoriteButton()
    }
    
    // MARK: - Base
    
    override func setViews() {
        coverImageView.do {
            $0.backgroundColor = .gray100
            $0.contentMode = .scaleAspectFill
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.numberOfLines = 1
            $0.textAlignment = .left
        }
        
        authorLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .darkGray
            $0.textAlignment = .left
        }
        
        publisherLabel.do {
            $0.font = . systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .darkGray
            $0.textAlignment = .left
        }
        
        publicationDateLabel.do {
            $0.font = . systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .darkGray
            $0.textAlignment = .left
        }
        
        availabilityLabel.do {
            $0.font = . systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .systemGreen
            $0.textAlignment = .left
            $0.text = "대출 가능"
        }
        
        bookInfoStackView.do {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(authorLabel)
            $0.addArrangedSubview(publisherLabel)
            $0.addArrangedSubview(publicationDateLabel)
            $0.addArrangedSubview(availabilityLabel)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 5
        }
        
        favoriteButton.do {
            $0.tintColor = .systemRed
            $0.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        [coverImageView, bookInfoStackView, favoriteButton].forEach {
            contentView.addSubview($0)
        }
        
        coverImageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(110)
            $0.height.equalTo(160).priority(.high)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(coverImageView)
            $0.left.equalTo(coverImageView.snp.right).offset(15)
            $0.right.equalToSuperview().inset(15)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.bottom.equalTo(coverImageView.snp.bottom)
            $0.right.equalTo(-15)
        }
    }
    
    // MARK: - Helpers
    
    func bind(_ detailBookInfo: DetailBookInfo) {
        self.detailBookInfo = detailBookInfo
        coverImageView.image = UIImage(named: detailBookInfo.basicBookInfo.coverImageURL)
        titleLabel.text = detailBookInfo.basicBookInfo.title
        authorLabel.text = detailBookInfo.basicBookInfo.author
        publisherLabel.text = detailBookInfo.publisher
        publicationDateLabel.text = detailBookInfo.publicationDate
        availabilityLabel.text = detailBookInfo.isAvailable ? "대출 가능" : "대출 불가능"
        availabilityLabel.textColor = detailBookInfo.isAvailable ? .systemGreen : .systemRed
        isFavorite = detailBookInfo.isFavorite
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName)?
            .withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            ), for: .normal
        )
    }
}
