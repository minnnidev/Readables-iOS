//
//  BookImageCell.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class BookImageCell: BaseCollectionViewCell {

    // MARK: - Properties

    private let bookImageView = UIImageView()
    private let bookNameLabel = UILabel()
    
    private let bookNameLabelForLargeLayout = UILabel()
    private let bookAuthorLabelForLargeLayout = UILabel()
    private let stackViewForLargeLayout = UIStackView()
    
    private var layoutType: LayoutType = .small

    // MARK: - UI Setup

    override func setViews() {
        contentView.backgroundColor = .clear

        bookImageView.do {
            $0.backgroundColor = .gray100
        }

        bookNameLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.lineBreakMode = .byTruncatingTail
            $0.numberOfLines = 2
        }
        
        bookNameLabelForLargeLayout.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.numberOfLines = 0
        }
        
        bookAuthorLabelForLargeLayout.do {
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = .gray100
            $0.numberOfLines = 0
        }
        
        stackViewForLargeLayout.do {
            $0.addArrangedSubview(bookNameLabelForLargeLayout)
            $0.addArrangedSubview(bookAuthorLabelForLargeLayout)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 5
        }
    }

    override func setConstraints() {
        contentView.subviews.forEach { $0.removeFromSuperview() }

        switch layoutType {
        case .small:
            configureSmallLayout()
        case .large:
            configureLargeLayout()
        }
    }

    func bind(with book: BookDisplayable, layoutType: LayoutType) {
        self.layoutType = layoutType
        setConstraints()
        
        if layoutType == .large {
            bookNameLabelForLargeLayout.text = book.title
            bookAuthorLabelForLargeLayout.text = book.author
        } else {
            guard let url = URL(string: book.imageURL) else { return }
            bookImageView.kf.setImage(with: url)
            
            bookNameLabel.text = book.title
        }
    }
}

// MARK: - Configure Cell Layout

private extension BookImageCell {
    
    func configureSmallLayout() {
        [bookImageView, bookNameLabel].forEach {
            contentView.addSubview($0)
        }
        
        bookImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func configureLargeLayout() {
        contentView.addSubview(stackViewForLargeLayout)

        stackViewForLargeLayout.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
