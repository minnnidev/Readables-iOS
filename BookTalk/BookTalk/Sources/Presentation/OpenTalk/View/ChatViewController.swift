//
//  ChattingViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import UIKit

import SnapKit
import Then

final class ChatViewController: BaseViewController {

    private let chatTableView = UITableView(frame: .zero)
    private let textInputView = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton()

    private let viewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
    }

    override func setNavigationBar() {
        navigationItem.title = "책 제목"

        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonDidTapped)
        )

        navigationItem.rightBarButtonItem = menuButton
    }

    override func setViews() {
        view.backgroundColor = .white

        chatTableView.do {
            $0.showsVerticalScrollIndicator = true
            $0.backgroundColor = UIColor(hex: 0xFFDCDC) // TODO: 색상 변경
            $0.separatorStyle = .none
        }

        textInputView.do {
            $0.backgroundColor = .white
        }

        messageTextField.do {
            $0.placeholder = "대화를 입력해 주세요"
            $0.layer.borderColor = UIColor.gray100.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
        }

        sendButton.do {
            $0.setImage(UIImage(systemName: "paperplane"), for: .normal)
            $0.tintColor = .black
        }
    }

    override func setConstraints() {
        [chatTableView, textInputView].forEach {
            view.addSubview($0)
        }

        [messageTextField, sendButton].forEach {
            textInputView.addSubview($0)
        }

        chatTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        textInputView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        messageTextField.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(8)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }

        sendButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
            $0.width.height.equalTo(30)
        }
    }

    private func setDelegate() {
        chatTableView.dataSource = self
    }

    private func registerCell() {
        chatTableView.register(OtherChatBubbleCell.self, forCellReuseIdentifier: OtherChatBubbleCell.identifier)
        chatTableView.register(MyChatBubbleCell.self, forCellReuseIdentifier: MyChatBubbleCell.identifier)
    }

    @objc private func menuButtonDidTapped() {
        // TODO: 사이드바 등장
    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = viewModel.chats[indexPath.row]

        if chat.isMine {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatBubbleCell.identifier, for: indexPath) as? OtherChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: chat)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatBubbleCell.identifier, for: indexPath) as? MyChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: chat.message)

            return cell
        }
    }
}
