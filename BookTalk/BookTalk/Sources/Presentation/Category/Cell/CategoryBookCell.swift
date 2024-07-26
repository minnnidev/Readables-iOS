//
//  CategoryBookCell.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class CategoryBookCell: UITableViewCell {
    
    static let identifier = "CategoryBookCell"

    private let bookImageView = UIImageView()

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

        bookImageView.do {
            $0.backgroundColor = .gray100
        }
    }

    private func setConstraints() {
        [bookImageView].forEach {
            contentView.addSubview($0)
        }

        bookImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
