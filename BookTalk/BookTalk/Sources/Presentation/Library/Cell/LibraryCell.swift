//
//  LibraryCell.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import UIKit

final class LibraryCell: BaseTableViewCell {

    // MARK: - Properties

    private let libraryNameLabel = UILabel()
    private let addressLabel = UILabel()
    private let telNumberLabel = UILabel()

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none

        libraryNameLabel.do {
            $0.textColor = .accentOrange
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }

        addressLabel.do {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }

        telNumberLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }

    override func setConstraints() {
        [libraryNameLabel, addressLabel, telNumberLabel].forEach {
            contentView.addSubview($0)
        }

        libraryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(libraryNameLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(libraryNameLabel)
        }

        telNumberLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.leading.equalTo(libraryNameLabel)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    func bind(with library: LibraryInfo) {
        libraryNameLabel.text = library.name
        addressLabel.text = library.address
        telNumberLabel.text = "TEL: \(library.tel ?? "")"
    }
}
