//
//  SearchCell.swift
//  BookTalk
//
//  Created by RAFA on 7/31/24.
//

import UIKit

import SnapKit
import Then

final class SearchCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let coverImageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publicationDateLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    
    private let availabilityLabel = UILabel()
    
    private let favoriteButton = UIButton(type: .system)
    private let bookmarkButton = UIButton(type: .system)
    private let buttonStackView = UIStackView()
    
    private var isFavorite: Bool = false
    private var isBookmarked: Bool = false
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonDidTap() {
        isFavorite.toggle()
        updateFavoriteButton()
    }
    
    @objc private func bookmarkButtonDidTap() {
        isBookmarked.toggle()
        updateBookmarkButton()
    }
    
    // MARK: - Helpers
    
    func bind(_ book: SearchBook) {
        coverImageView.image = UIImage(named: "\(book.coverImageURL)")
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
        publicationDateLabel.text = book.publicationDate
        if book.availability {
            availabilityLabel.text = "대출 가능"
            availabilityLabel.textColor = .systemGreen
        } else {
            availabilityLabel.text = "대출 불가능"
            availabilityLabel.textColor = .systemRed
        }
        isFavorite = book.isFavorite
        isBookmarked = book.isBookmarked
        updateFavoriteButton()
        updateBookmarkButton()
    }
    
    private func updateFavoriteButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName)?
            .withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            ), for: .normal
        )
    }
    
    private func updateBookmarkButton() {
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: imageName)?
            .withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            ), for: .normal
        )
    }
    
    // MARK: - Set UI
    
    private func setViews() {
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
        
        bookmarkButton.do {
            $0.tintColor = .accentGreen
            $0.addTarget(self, action: #selector(bookmarkButtonDidTap), for: .touchUpInside)
        }
        
        buttonStackView.do {
            $0.addArrangedSubview(favoriteButton)
            $0.addArrangedSubview(bookmarkButton)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 5
        }
    }
    
    private func setConstraints() {
        [coverImageView, bookInfoStackView, buttonStackView].forEach {
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
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(coverImageView.snp.bottom)
            $0.right.equalTo(-15)
        }
    }
}
