//
//  BookInfoCell.swift
//  BookTalk
//
//  Created by RAFA on 8/2/24.
//

import UIKit

import SnapKit
import Then

final class BookInfoCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let bookImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publicationDateLabel = UILabel()
    private let availabilityLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind( _ viewModel: BookDetailViewModel) {
        bookImageView.image = UIImage(named: "\(viewModel.coverImageURL)")
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        publisherLabel.text = viewModel.publisher
        publicationDateLabel.text = viewModel.publicationDate
        availabilityLabel.text = viewModel.availabilityText
        availabilityLabel.textColor = viewModel.availabilityTextColor
    }
    
    // MARK: - Set UI
    
    private func setViews() {
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
    }
    
    private func setConstraints() {
        [bookImageView, titleLabel, bookInfoStackView].forEach {
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
            $0.bottom.equalTo(-15)
        }
    }
}
