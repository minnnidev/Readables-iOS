//
//  CategoryTitleCell.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class CategoryTitleCell: BaseTableViewCell {

    // MARK: - Properties

    private let firstCategoryTitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let subcategoryTitleLabel = UILabel()
    private let selectIcon = UIImageView()

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none

        contentView.backgroundColor = .clear

        firstCategoryTitleLabel.do {
            $0.font = .systemFont(ofSize: 23, weight: .bold)
            $0.textColor = .accentOrange
        }

        chevronImageView.do {
            $0.image = UIImage(systemName: "chevron.right")
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }

        subcategoryTitleLabel.do {
            $0.font = .systemFont(ofSize: 23, weight: .bold)
            $0.textColor = .accentOrange
        }

        selectIcon.do {
            $0.image = UIImage(systemName: "chevron.up.chevron.down")
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }
    }

    override func setConstraints() {
        [
            firstCategoryTitleLabel, chevronImageView,
            subcategoryTitleLabel, selectIcon
        ].forEach {
            contentView.addSubview($0)
        }

        firstCategoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }

        chevronImageView.snp.makeConstraints {
            $0.centerY.equalTo(firstCategoryTitleLabel)
            $0.leading.equalTo(firstCategoryTitleLabel.snp.trailing).offset(4)
        }

        subcategoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(firstCategoryTitleLabel)
            $0.leading.equalTo(chevronImageView.snp.trailing).offset(4)
        }

        selectIcon.snp.makeConstraints {
            $0.centerY.equalTo(firstCategoryTitleLabel)
            $0.leading.equalTo(subcategoryTitleLabel.snp.trailing).offset(8)
            $0.height.equalTo(25)
        }
    }

    // MARK: - Helpers

    func bind(_ category: Category) {
        firstCategoryTitleLabel.text = category.firstCategory
        subcategoryTitleLabel.text = category.subcategory
    }
}
