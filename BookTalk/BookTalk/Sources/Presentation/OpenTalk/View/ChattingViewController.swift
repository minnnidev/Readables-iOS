//
//  ChattingViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import UIKit

import SnapKit
import Then

final class ChattingViewController: BaseViewController {

    private let chatTableView = UITableView(frame: .zero)

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
    }

    override func setConstraints() {
        [chatTableView].forEach {
            view.addSubview($0)
        }

        chatTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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

extension ChattingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let random = [0, 1].randomElement()!

        if random == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatBubbleCell.identifier, for: indexPath) as? OtherChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: viewModel.chats[indexPath.row])

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatBubbleCell.identifier, for: indexPath) as? MyChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: viewModel.chats[indexPath.row].message)

            return cell
        }
    }
}
