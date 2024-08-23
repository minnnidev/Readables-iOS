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
    
    // MARK: - Helpers

    func bind(with book: Book) {
        bookNameLabel.text = book.title
        
        if let url = URL(string: book.imageURL) {
            bookImageView.kf.setImage(with: url)
        } else {
            bookImageView.kf.cancelDownloadTask()
            bookImageView.image = nil
        }
    }

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
    }

    override func setConstraints() {
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
}
