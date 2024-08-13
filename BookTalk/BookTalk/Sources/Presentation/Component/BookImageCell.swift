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

    // MARK: - UI Setup

    override func setViews() {
        contentView.backgroundColor = .clear

        bookImageView.do {
            $0.backgroundColor = .gray100
        }

        bookNameLabel.do {
            $0.text = "당신도논리적으로말할수있습니다줄바꿈테스트"
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
        }

        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
