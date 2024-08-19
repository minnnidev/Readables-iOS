//
//  SearchHistoryCell.swift
//  BookTalk
//
//  Created by RAFA on 8/1/24.
//

import UIKit

protocol SearchHistoryCellDelegate: AnyObject {
    
    func didTapDeleteButton(cell: SearchHistoryCell)
}

final class SearchHistoryCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SearchHistoryCellDelegate?
    
    private let titleLabel = UILabel()
    private let deleteButton = UIButton()
    
    // MARK: - Actions
    
    @objc private func deleteButtonDidTap() {
        delegate?.didTapDeleteButton(cell: self)
    }
    
    // MARK: - Bind
    
    func bind(_ text: String) {
        titleLabel.text = text
        deleteButton.isHidden = (text == "최근 검색어가 없습니다.")
        
        if text == "최근 검색어가 없습니다." {
            titleLabel.textColor = .systemGray
        } else {
            titleLabel.textColor = .black
        }
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        titleLabel.do {
            $0.numberOfLines = 1
            $0.textColor = .systemGray
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        deleteButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .darkGray
            $0.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        }
    }
    
    override func setConstraints() {
        [titleLabel, deleteButton].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(15)
            $0.right.equalTo(deleteButton.snp.left).offset(-10)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-15)
            $0.left.equalTo(titleLabel.snp.right).offset(10)
            $0.size.equalTo(20)
        }
    }
}
