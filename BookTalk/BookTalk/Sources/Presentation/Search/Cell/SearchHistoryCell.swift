//
//  SearchHistoryCell.swift
//  BookTalk
//
//  Created by RAFA on 8/1/24.
//

import UIKit

import SnapKit
import Then

protocol SearchHistoryCellDelegate: AnyObject {
    func didTapDeleteButton(cell: SearchHistoryCell)
}

final class SearchHistoryCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SearchHistoryCellDelegate?
    private let titleLabel = UILabel()
    private let deleteButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func deleteButtonDidTap() {
        delegate?.didTapDeleteButton(cell: self)
    }
    
    // MARK: - Helpers
    
    func bind(_ text: String) {
        titleLabel.text = text
        deleteButton.isHidden = (text == "최근 검색어가 없습니다.")
    }
    
    // MARK: - Set UI
    
    private func setViews() {
        titleLabel.do {
            $0.text = "최근 검색어"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        deleteButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .darkGray
            $0.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setConstraints() {
        [titleLabel, deleteButton].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }
}
