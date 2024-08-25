//
//  LikedTitleHeaderView.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import UIKit

final class LikedTitleHeaderView: BaseCollectionViewHeaderFooterView {

    private let titleLabel = UILabel()

    override func setViews() {
        titleLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.text = "\(UserData.shared.getUser()?.nickname ?? "알 수 없음")님이 찜한 책" 
            $0.textColor = .black
        }
    }

    override func setConstraints() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
