//
//  SuggestionCell.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class SuggestionCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let backgroundImageView = UIImageView()
    private let suggestionLabel = UILabel()
    private var viewModel = HomeViewModel()

    // MARK: - Bind
    
    func bind(_ text: String) {
        suggestionLabel.text = text

        viewModel.currentBackgroundImage.subscribe { [weak self] imageName in
            guard let self = self else { return }
            UIView.transition(
                with: backgroundImageView,
                duration: 0.5,
                options: .transitionCrossDissolve
            ) {
                self.backgroundImageView.image = UIImage(named: imageName)
            }
        }

        viewModel.send(action: .loadBackgroundImageView)
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
