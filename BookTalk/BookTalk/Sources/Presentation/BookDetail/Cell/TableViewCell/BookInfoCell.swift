//
//  BookInfoCell.swift
//  BookTalk
//
//  Created by RAFA on 8/5/24.
//

import UIKit

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
    
    // MARK: - Bind
    
    func bind(_ viewModel: BookDetailViewModel) {
        viewModel.output.coverImageURL.subscribe { [weak self] urlString in
            self?.bookImageView.image = UIImage(named: urlString)
        }
        
        viewModel.output.title.subscribe { [weak self] title in
            self?.titleLabel.text = title
        }
        
        viewModel.output.author.subscribe { [weak self] author in
            self?.authorLabel.text = author
        }
        
        viewModel.output.publisher.subscribe { [weak self] publisher in
            self?.publisherLabel.text = publisher
        }
        
        viewModel.output.publicationDate.subscribe { [weak self] publicationDate in
            self?.publicationDateLabel.text = publicationDate
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
            $0.backgroundColor = .gray100
        }
        
        titleLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 25, weight: .bold)
        }
        
        authorLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publisherLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publicationDateLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        availabilityLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
        }
        
        bookInfoStackView.do {
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
    }
    
    override func setConstraints() {
        [bookImageView, titleLabel, bookInfoStackView, joinOpenTalkButton].forEach {
            contentView.addSubview($0)
        }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            $0.left.equalTo(15)
            $0.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookImageView.snp.bottom).offset(10)
            $0.left.equalTo(bookImageView)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.centerX.left.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        joinOpenTalkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bookInfoStackView.snp.bottom).offset(15)
            $0.left.equalTo(bookInfoStackView)
            $0.bottom.equalToSuperview().offset(-15)
            $0.height.equalTo(50)
        }
    }
}
