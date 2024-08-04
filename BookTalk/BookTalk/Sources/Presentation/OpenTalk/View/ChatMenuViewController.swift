//
//  ChatSideMenuViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/4/24.
//

import UIKit

import SnapKit
import Then

final class ChatMenuViewController: BaseViewController {

    private let chatMenuTableView = UITableView()
    private let bottomLineView = UIView()
    private let bottomView = UIView()
    private let shareGoalButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViews() {
        view.backgroundColor = .white

        chatMenuTableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .red
        }

        bottomLineView.do {
            $0.backgroundColor = .gray100
        }

        bottomView.do {
            $0.backgroundColor = .white
        }

        shareGoalButton.do {
            $0.setTitle("오픈톡에 목표 공유하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(hex: 0xFFCC00) // TODO: 색상
            $0.layer.cornerRadius = 10
        }
    }

    override func setConstraints() {
        [chatMenuTableView, bottomLineView, bottomView].forEach {
            view.addSubview($0)
        }

        bottomView.addSubview(shareGoalButton)

        chatMenuTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-70)
        }

        bottomLineView.snp.makeConstraints {
            $0.bottom.equalTo(bottomView.snp.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }

        bottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }

        shareGoalButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
    }
}
