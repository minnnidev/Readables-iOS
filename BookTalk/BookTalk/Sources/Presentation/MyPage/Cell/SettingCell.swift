//
//  SettingCell.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import UIKit

final class SettingCell: BaseTableViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()
    private let contentLabel = UILabel()

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
        }

        contentLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.textColor = .lightGray
        }
    }

    override func setConstraints() {
        [titleLabel, contentLabel].forEach {
            contentView.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }

    func bind(title: String, content: String?) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
