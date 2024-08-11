//
//  ChattingViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/2/24.
//

import UIKit

final class ChatViewController: BaseViewController {

    // MARK: - Properties

    private let chatTableView = UITableView(frame: .zero)
    private let textInputView = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton()
    private var bookmarkBarButton = UIBarButtonItem()

    private let viewModel: ChatViewModel

    // MARK: - Initializer

    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
        setKeyboardNotifications()
        addTapGesture()
        addTarget()
        bind()
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "책 제목"

        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(menuButtonDidTapped)
        )

        bookmarkBarButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(bookmarkButtonDidTapped)
        )

        navigationItem.rightBarButtonItems = [menuButton, bookmarkBarButton]
    }

    override func setViews() {
        view.backgroundColor = .white

        chatTableView.do {
            $0.showsVerticalScrollIndicator = true
            $0.backgroundColor = UIColor(hex: 0xFFC4A3)
            $0.separatorStyle = .none
            $0.keyboardDismissMode = .onDrag
        }

        textInputView.do {
            $0.backgroundColor = .white
        }

        messageTextField.do {
            $0.layer.borderColor = UIColor.gray100.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
            $0.leftViewMode = .always
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
            $0.height.equalTo(55)
        }

        messageTextField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }

        sendButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
            $0.width.height.equalTo(30)
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        chatTableView.dataSource = self
    }

    private func registerCell() {
        chatTableView.register(OtherChatBubbleCell.self, forCellReuseIdentifier: OtherChatBubbleCell.identifier)
        chatTableView.register(MyChatBubbleCell.self, forCellReuseIdentifier: MyChatBubbleCell.identifier)
    }

    private func setKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func addTarget() {
        messageTextField.addTarget(
            self,
            action: #selector(textFieldDidChanged(_:)),
            for: .editingChanged
        )
    }

    private func bind() {
        viewModel.send(action: .loadChats)
        
        viewModel.chats.subscribe { [weak self] chats in
            self?.chatTableView.reloadData()
        }

        viewModel.isBookmarked.subscribe { [weak self] state in
            self?.bookmarkBarButton.image = state ?
                UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        }

        viewModel.message.subscribe { [weak self] text in
            self?.sendButton.isEnabled = !text.isEmpty
        }
    }

    // MARK: - Actions

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom

            textInputView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-keyboardHeight)
            }

            view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        textInputView.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        view.layoutIfNeeded()
    }

    @objc private func menuButtonDidTapped() {
        let chatMenuVC = ChatMenuViewController()
        navigationController?.pushViewController(chatMenuVC, animated: true)
    }

    @objc private func bookmarkButtonDidTapped() {
        viewModel.send(action: .toggleBookmark)
    }

    @objc private func textFieldDidChanged(_ textField: UITextField) {
        viewModel.send(action: .textFieldChanged(text: textField.text ?? ""))
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = viewModel.chats.value[indexPath.row]

        if chat.isMine {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OtherChatBubbleCell.identifier,
                for: indexPath
            ) as? OtherChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: chat)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MyChatBubbleCell.identifier,
                for: indexPath
            ) as? MyChatBubbleCell else { return UITableViewCell() }

            cell.bind(with: chat.message)

            return cell
        }
    }
}
