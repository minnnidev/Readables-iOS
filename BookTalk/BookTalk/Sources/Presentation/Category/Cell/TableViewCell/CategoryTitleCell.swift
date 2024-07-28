//
//  CategoryTitleCell.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class CategoryTitleCell: UITableViewCell {

    static let identifier = "CategoryTitleCell"

    private let firstCategoryTitleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let secondCategoryTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        selectionStyle = .none

        contentView.backgroundColor = .clear

        firstCategoryTitleLabel.do {
            $0.font = .systemFont(ofSize: 23, weight: .bold)
            $0.textColor = .accentGreen
        }

        chevronImageView.do {
            $0.image = UIImage(systemName: "chevron.right")
            $0.tintColor = .black
            $0.contentMode = .scaleAspectFit
        }

        secondCategoryTitleLabel.do {
            $0.font = .systemFont(ofSize: 23, weight: .bold)
            $0.textColor = .accentGreen
        }
    }

    private func setConstraints() {
        [firstCategoryTitleLabel, chevronImageView, secondCategoryTitleLabel].forEach {
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
            $0.height.equalTo(15)
        }

        secondCategoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(firstCategoryTitleLabel)
            $0.leading.equalTo(chevronImageView.snp.trailing).offset(4)
        }
    }

    func bind(_ category: Category) {
        firstCategoryTitleLabel.text = category.firstCatgory
        secondCategoryTitleLabel.text = category.secondCategory
    }
}
