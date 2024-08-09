//
//  FirstCategoryCell.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import UIKit

final class FirstCategoryCell: BaseCollectionViewCell {

    // MARK: - Properties

    private let categoryNameLabel = UILabel()

    // MARK: - UI Setup

    override func setViews() {
        contentView.backgroundColor = .white

        contentView.do {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray100.cgColor
        }

        categoryNameLabel.do {
            $0.font = .systemFont(ofSize: 18, weight: .semibold)
            $0.textColor = .black
        }
    }

    override func setConstraints() {
        [categoryNameLabel].forEach {
            contentView.addSubview($0)
        }

        categoryNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }

    // MARK: - Helpers

    func bind(_ title: String) {
        categoryNameLabel.text = title
    }
}
