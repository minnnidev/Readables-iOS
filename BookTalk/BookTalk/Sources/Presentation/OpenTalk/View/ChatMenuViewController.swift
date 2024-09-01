//
//  ChatSideMenuViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/4/24.
//

import UIKit

final class ChatMenuViewController: BaseViewController {

    // MARK: - Properties

    private let chatMenuTableView = UITableView()
    private let bottomLineView = UIView()
    private let bottomView = UIView()
    private let shareGoalButton = UIButton()

    private let viewModel: ChatMenuViewModel

    // MARK: - Initializer

    init(viewModel: ChatMenuViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
        bind()

        viewModel.send(action: .loadChatMenu(isbn: viewModel.isbn))
    }

    // MARK: - Bind

    private func bind() {
        viewModel.loadState.subscribe { state in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch state {
                case .initial:
                    break
                case .loading:
                    chatMenuTableView.isHidden = true

                case .completed:
                    chatMenuTableView.reloadData()
                    chatMenuTableView.isHidden = false
                }
            }
        }

        viewModel.createGoalSucceed.subscribe { isSucceed in
            guard isSucceed else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let goalId = viewModel.createdGoalId else { return }

                pushToDetailGoalViewController(goalId: goalId)
            }
        }
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.backButtonTitle = ""
    }

    override func setViews() {
        view.backgroundColor = .white

        chatMenuTableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.separatorInset = .zero
            $0.estimatedRowHeight = 300
        }

        shareGoalButton.do {
            $0.setTitle("오픈톡에 목표 공유하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.accentOrange
        }
    }

    override func setConstraints() {
        [chatMenuTableView].forEach {
            view.addSubview($0)
        }

        chatMenuTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }

//        shareGoalButton.snp.makeConstraints {
//            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(70)
//        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        chatMenuTableView.dataSource = self
        chatMenuTableView.delegate = self
    }

    private func registerCell() {
        chatMenuTableView.register(
            NowReadingCell.self,
            forCellReuseIdentifier: NowReadingCell.identifier
        )
        chatMenuTableView.register(
            MyReadingProgressCell.self,
            forCellReuseIdentifier: MyReadingProgressCell.identifier
        )
        chatMenuTableView.register(
            NotStartedReadingCell.self,
            forCellReuseIdentifier: NotStartedReadingCell.identifier
        )
        chatMenuTableView.register(
            CompletedReadingCell.self,
            forCellReuseIdentifier: CompletedReadingCell.identifier
        )
    }

    private func pushToDetailGoalViewController(goalId: Int) {
        let viewModel = DetailGoalViewModel(goalId: goalId)
        let detailGoalVC = DetailGoalViewController(viewModel: viewModel)

        navigationController?.pushViewController(detailGoalVC, animated: true)
    }

    private func pushToAddBookViewController() {
        let viewModel = AddBookViewModel(addBookType: .goalBook)
        let addBookVC = AddBookViewController(viewModel: viewModel)

        navigationController?.pushViewController(addBookVC, animated: true)
    }

    private func configureCreateGoalAlert() {
        let alertVC = UIAlertController(
            title: "목표 추가",
            message: "총 페이지 수를 입력해 주세요.",
            preferredStyle: .alert
        )

        alertVC.addTextField { tf in
            tf.placeholder = "페이지 수"
            tf.keyboardType = .numberPad
            tf.addTarget(
                self,
                action: #selector(self.textDidChange(_:)),
                for: .editingChanged
            )
        }

        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel,
            handler: nil
        )

        let okAction = UIAlertAction(title: "완료", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if let textField = alertVC.textFields?.first {
                viewModel.send(
                    action: .addGoal(isbn: viewModel.isbn, totalPage: textField.text ?? "0")
                )
            }
        }

        okAction.isEnabled = false

        [cancelAction, okAction].forEach { alertVC.addAction($0) }

        present(alertVC, animated: true)
    }

    @objc private func textDidChange(_ textField: UITextField) {
        guard let alertVC = self.presentedViewController as? UIAlertController,
              let okAction = alertVC.actions.last else {
            return
        }
        okAction.isEnabled = !(textField.text?.isEmpty ?? true)
    }
}

// MARK: - UITableViewDataSource

extension ChatMenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return ChatMenuSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = ChatMenuSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        guard let nowReadingCell = tableView.dequeueReusableCell(
            withIdentifier: NowReadingCell.identifier,
            for: indexPath
        ) as? NowReadingCell,
              let readingProgressCell = tableView.dequeueReusableCell(
                withIdentifier: MyReadingProgressCell.identifier,
                for: indexPath
              ) as? MyReadingProgressCell,
              let completedReadingCell = tableView.dequeueReusableCell(
                withIdentifier: CompletedReadingCell.identifier,
                for: indexPath
              ) as? CompletedReadingCell,
              let notStartedReadingCell = tableView.dequeueReusableCell(
                withIdentifier: NotStartedReadingCell.identifier,
                for: indexPath
              ) as? NotStartedReadingCell
        else { return UITableViewCell() }


        switch sectionType {
        case .nowReading:
            nowReadingCell.bind(with: viewModel.progressingUsers.value)
            return nowReadingCell

        case .myProgress:
            if let rate = viewModel.myProgress.value?.progressRate {
                readingProgressCell.bind(percent: Int(rate))

                return readingProgressCell
            } else {
                notStartedReadingCell.addButtonDidTappedObservable.subscribe { [weak self] isTapped in
                    guard isTapped else { return }

                    self?.configureCreateGoalAlert()
                }
                return notStartedReadingCell
            }

        case .completedReading:
            completedReadingCell.bind(with: viewModel.completedUsers.value)
            return completedReadingCell
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatMenuViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}
