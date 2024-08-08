//
//  SuggestionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

import SnapKit
import Then

final class SuggestionCell: UITableViewCell {
    
    // MARK: - Properties
    
    let backgroundImageView = UIImageView()
    let suggestionLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind(_ text: String) {
        suggestionLabel.text = text
    }
}

// MARK: - UI Setup

private extension SuggestionCell {
    
    func setupUI() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(suggestionLabel)
        
        configureComponents()
        setupConstraints()
    }
    
    func configureComponents() {
        backgroundImageView.do {
            $0.image = UIImage(named: "homeBackgroundImage")
            $0.contentMode = .scaleAspectFill
        }
        
        suggestionLabel.do {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 20, weight: .heavy)
            $0.textColor = .white
        }
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.centerX.left.bottom.equalToSuperview()
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
        }
        
        suggestionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
