//
//  NowReadingPeopleCell.swift
//  BookTalk
//
//  Created by 김민 on 8/8/24.
//

import UIKit

import SnapKit
import Then

final class ReadingPeopleCell: BaseTableViewCell {

    // MARK: - Properties

    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let percentLabel = UILabel()

    // MARK: - Bind

    func bind(with user: GoalUserModel?) {
        guard let user = user else { return }
        
        nicknameLabel.text = "\(user.nickname)"
        percentLabel.text = "\(Int(user.progressRate))%"
    }

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        contentView.backgroundColor = .clear

        // TODO: 프로필 이미지 이후 추가
//        profileImageView.do {
//            $0.backgroundColor = .gray100
//        }

        nicknameLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.text = "닉네임"
        }

        percentLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.textColor = .accentOrange
            $0.text = "80%"
        }
    }

    override func setConstraints() {
        [nicknameLabel, percentLabel].forEach {
            contentView.addSubview($0)
        }

//        profileImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().offset(20)
//            $0.width.height.equalTo(45)
//        }

        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        percentLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
