//
//  LibrarySimpleCell.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import UIKit

final class LibrarySimpleCell: BaseTableViewCell {

    private let libraryNameLabel = UILabel()

    override func setViews() {
        selectionStyle = .none

        contentView.backgroundColor = .clear

        libraryNameLabel.do {
            $0.text = "신당 작은 누리도서관"
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }

    override func setConstraints() {
        contentView.addSubview(libraryNameLabel)

        libraryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    func bind(with name: String) {
        libraryNameLabel.text = name 
    }
}
