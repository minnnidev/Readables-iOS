//
//  CategoryCollectionViewCell.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import UIKit
import SnapKit
import Then

final class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "CategoryCollectionViewCell"

    private let categoryNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        contentView.backgroundColor = .white

        contentView.do {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
        }

        categoryNameLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.text = "카테고리"
            $0.textColor = .black
        }
    }

    private func setConstraints() {
        [categoryNameLabel].forEach {
            contentView.addSubview($0)
        }

        categoryNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }
}
