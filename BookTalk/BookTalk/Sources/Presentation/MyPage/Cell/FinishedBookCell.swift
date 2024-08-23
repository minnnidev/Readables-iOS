//
//  FinishedBookCell.swift
//  BookTalk
//
//  Created by RAFA on 8/23/24.
//

import UIKit

final class FinishedBookCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    private let bookNameLabel = UILabel()
    private let bookAuthorLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    
    // MARK: - Helpers
    
    func bind(with book: FinishedBook) {
        bookNameLabel.text = book.bookName
        bookAuthorLabel.text = book.bookAuthor
    }
    
    // MARK: - UI Setup

    override func setViews() {
        contentView.backgroundColor = .clear
        
        bookNameLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.numberOfLines = 0
        }
        
        bookAuthorLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = .gray100
            $0.numberOfLines = 0
        }
        
        bookInfoStackView.do {
            $0.addArrangedSubview(bookNameLabel)
            $0.addArrangedSubview(bookAuthorLabel)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 5
        }
    }

    override func setConstraints() {
        contentView.addSubview(bookInfoStackView)

        bookInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
