//
//  BookInfoCell.swift
//  BookTalk
//
//  Created by RAFA on 8/5/24.
//

import UIKit

import Kingfisher

final class BookInfoCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let bookImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publicationDateLabel = UILabel()
    private let availabilityLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    private let joinOpenTalkButton = UIButton(type: .system)
    private let markAsReadButton = UIButton(type: .system)
    
    // MARK: - Bind

    func bind(_ viewModel: BookDetailViewModel) {
        viewModel.output.detailBook.subscribe { [weak self] detail in
            guard let self = self else { return }
            guard let detail = detail else { return }

            titleLabel.text = detail.basicBookInfo.title
            authorLabel.text = detail.basicBookInfo.author
            publisherLabel.text = detail.publisher
            publicationDateLabel.text = detail.publicationDate

            guard let imageURL = URL(string: detail.basicBookInfo.coverImageURL) else { return }
            bookImageView.kf.setImage(with: imageURL)
        }

        viewModel.output.availabilityText.subscribe { [weak self] availabilityText in
            self?.availabilityLabel.text = availabilityText
        }
        
        viewModel.output.availabilityTextColor.subscribe { [weak self] textColor in
            self?.availabilityLabel.textColor = textColor
        }
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        bookImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 23, weight: .bold)
        }
        
        authorLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publisherLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publicationDateLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        availabilityLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .bold)
        }
        
        bookInfoStackView.do {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(authorLabel)
            $0.addArrangedSubview(publisherLabel)
            $0.addArrangedSubview(publicationDateLabel)
            $0.addArrangedSubview(availabilityLabel)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
            $0.spacing = 5
        }
        
        joinOpenTalkButton.do {
            $0.backgroundColor = .accentOrange
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.setTitle("오픈톡 참여하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        }
        
        markAsReadButton.do {
            var config = UIButton.Configuration.plain()
            config.attributedTitle = AttributedString(
                NSAttributedString(
                    string: "읽은 책으로 추가하기",
                    attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
                )
            )
            config.image = UIImage(systemName: "plus")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            config.imagePlacement = .trailing
            config.imagePadding = 5
            
            $0.configuration = config
        }
    }
    
    override func setConstraints() {
        [bookImageView,
         titleLabel,
         bookInfoStackView,
         joinOpenTalkButton,
         markAsReadButton].forEach { contentView.addSubview($0) }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            $0.left.equalTo(15)
            $0.height.equalTo(250)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.centerX.left.equalTo(bookImageView)
            $0.top.equalTo(bookImageView.snp.bottom).offset(10)
        }
        
        joinOpenTalkButton.snp.makeConstraints {
            $0.centerX.left.equalTo(bookInfoStackView)
            $0.top.equalTo(bookInfoStackView.snp.bottom).offset(15)
            $0.height.equalTo(50)
        }
        
        markAsReadButton.snp.makeConstraints {
            $0.centerX.left.equalTo(joinOpenTalkButton)
            $0.top.equalTo(joinOpenTalkButton.snp.bottom).offset(15)
            $0.bottom.equalTo(-15)
            $0.height.equalTo(30)
        }
    }
}
