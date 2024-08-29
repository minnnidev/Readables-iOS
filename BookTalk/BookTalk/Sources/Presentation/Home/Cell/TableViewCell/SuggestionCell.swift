//
//  SuggestionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class SuggestionCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    let backgroundImageView = UIImageView()
    let suggestionLabel = UILabel()
    
    // MARK: - Bind
    
    func bind(_ text: String) {
        suggestionLabel.text = text
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        backgroundImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        suggestionLabel.do {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 20, weight: .heavy)
            $0.textColor = .white
        }
    }
    
    override func setConstraints() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(suggestionLabel)
        
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
