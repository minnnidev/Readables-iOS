//
//  HomeHeaderView.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    var section: Int?
    private let titleLabel = UILabel()
    private let rightArrowIcon = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind(_ title: String, section: Int) {
        titleLabel.text = title
        self.section = section
    }
    
    // MARK: - Set UI
    
    private func setViews() {
        contentView.backgroundColor = .white
        
        titleLabel.do {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.textAlignment = .left
        }
        
        rightArrowIcon.do {
            $0.image = UIImage(named: "next")
            $0.tintColor = .black
        }
    }
    
    private func setConstraints() {
        [titleLabel, rightArrowIcon].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(15)
            $0.right.equalTo(rightArrowIcon.snp.left).offset(-15)
        }
        
        rightArrowIcon.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalTo(-15)
            $0.size.equalTo(20)
        }
    }
}
