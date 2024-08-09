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

    // MARK: - UI Setup

    override func setViews() {
        contentView.backgroundColor = .clear

        bookImageView.do {
            $0.backgroundColor = .gray100
        }
    }

    override func setConstraints() {
        [bookImageView].forEach {
            contentView.addSubview($0)
        }

        bookImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
