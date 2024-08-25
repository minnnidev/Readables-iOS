//
//  KeywordHeaderView.swift
//  BookTalk
//
//  Created by RAFA on 8/14/24.
//

import UIKit

protocol KeywordHeaderViewDelegate: AnyObject {
    func didTapKeywordHeader(section: Int)
}

final class KeywordHeaderView: BaseTableViewHeaderFooterView {
    
    // MARK: - Properties
    
    weak var delegate: KeywordHeaderViewDelegate?
    
    private let titleLabel = UILabel()
    private let toggleLabel = PaddedLabel()
    var isExpanded: Bool = false
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    
    @objc private func headerTapped() {
        isExpanded.toggle()
        toggleLabel.text = isExpanded ? "접기" : "펼치기"
        delegate?.didTapKeywordHeader(section: section ?? 1)
    }
    
    // MARK: - Bind
    
    func bind(_ isExpanded: Bool) {
        toggleLabel.text = isExpanded ? "접기" : "펼치기"
    }
    
    // MARK: - Helpers
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        contentView.backgroundColor = .white
        
        titleLabel.do {
            $0.text = "지난 달 키워드 확인하기"
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 18, weight: .medium)
            $0.textAlignment = .left
        }
        
        toggleLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.backgroundColor = .accentOrange
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
    }
    
    override func setConstraints() {
        [titleLabel, toggleLabel].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(15)
        }
        
        toggleLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalTo(-15)
        }
    }
}
