//
//  KeywordCollectionCell.swift
//  BookTalk
//
//  Created by RAFA on 8/14/24.
//

import UIKit

final class KeywordCollectionCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    let keywordLabel = PaddedLabel()
    
    // MARK: - Bind
    
    func bind(_ keyword: String) {
        keywordLabel.attributedText = createAttributedText(for: keyword)
    }
    
    // MARK: - Helpers
    
    private func createAttributedText(for keyword: String) -> NSAttributedString {
        let hashtagPrefix = "#"
        let hashtagColor: UIColor = .accentOrange
        let keywordColor: UIColor = .darkGray
        
        let fullText = hashtagPrefix + keyword
        let attributedText = NSMutableAttributedString(string: fullText)
        
        attributedText.addAttributes([
            .foregroundColor: hashtagColor
        ], range: NSRange(location: 0, length: hashtagPrefix.count))
        
        attributedText.addAttributes([
            .foregroundColor: keywordColor
        ], range: NSRange(location: hashtagPrefix.count, length: keyword.count))
        
        return attributedText
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        contentView.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        keywordLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textAlignment = .center
            $0.isUserInteractionEnabled = false
        }
    }
    
    override func setConstraints() {
        contentView.addSubview(keywordLabel)
        
        keywordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
