//
//  SuggestionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit
import WeatherKit

final class SuggestionCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let backgroundImageView = UIImageView()
    private let suggestionLabel = UILabel()
    private var viewModel = HomeViewModel()

    // MARK: - Bind
    
    func bind(_ text: String, weatherCondition: WeatherCondition?) {
        suggestionLabel.text = text
        backgroundImageView.image = UIImage.image(for: weatherCondition)
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
            $0.edges.equalToSuperview()
        }
        
        suggestionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
