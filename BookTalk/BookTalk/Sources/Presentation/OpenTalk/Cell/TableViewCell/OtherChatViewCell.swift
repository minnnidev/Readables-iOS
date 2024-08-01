//
//  ChatViewCell.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import UIKit

import SnapKit
import Then

final class OtherChatViewCell: UITableViewCell {

    static let identifier = "ChatViewCell"

    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let chatMessageLabel = UILabel()
    private let bubbleView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

    private func setViews() {
        selectionStyle = .none
        
        backgroundColor = .clear

        profileImageView.do {
            $0.backgroundColor = .gray100
            $0.layer.masksToBounds = false
            $0.clipsToBounds = true
        }

        nicknameLabel.do {
            $0.text = "닉네임"
            $0.font = .systemFont(ofSize: 13, weight: .regular)
            $0.textColor = .black
        }

        bubbleView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }

        chatMessageLabel.do {
            $0.text = "안녕하세용안녕하세용안녕하세용안녕하세용안녕하세용안녕하세용안녕하세용안녕하세용"
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
    }

    private func setConstraints() {
        [profileImageView, nicknameLabel, bubbleView].forEach {
            contentView.addSubview($0)
        }

        bubbleView.addSubview(chatMessageLabel)

        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(40)
        }

        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }

        bubbleView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nicknameLabel)
            $0.width.lessThanOrEqualTo(220)
            $0.bottom.equalToSuperview()
        }

        chatMessageLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
}
