//
//  SettingViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/15/24.
//

import UIKit

final class SettingViewController: BaseViewController {

    // MARK: - Properties

    private let settingTableView = UITableView()

    private let viewModel: SettingViewModel

    // MARK: - Initializer

    init(viewModel: SettingViewModel) {
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
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "환경 설정"
    }

    override func setViews() {
        view.backgroundColor = .white

        settingTableView.do {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            $0.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override func setConstraints() {
        [settingTableView].forEach {
            view.addSubview($0)
        }

        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }

    private func registerCell() {
        settingTableView.register(
            SettingCell.self,
            forCellReuseIdentifier: SettingCell.identifier
        )
    }

    private func presentLogoutActionSheet() {
        let alertVC = UIAlertController(
            title: "로그아웃하시겠습니까?",
            message: nil,
            preferredStyle: .actionSheet
        )

        let logoutAction = UIAlertAction(
            title: "로그아웃",
            style: .destructive) { [weak self] _ in
                self?.viewModel.send(action: .logout)
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        [logoutAction, cancelAction].forEach {
            alertVC.addAction($0)
        }

        present(alertVC, animated: true)
    }

    private func presentWithdrawActionSheet() {
        let alertVC = UIAlertController(
            title: "탈퇴하시겠습니까?",
            message: "탈퇴 시, 모든 개인 정보와 데이터가 영구적으로 삭제되며 복구가 불가능합니다. 계속 진행하시겠습니까?",
            preferredStyle: .alert
        )

        let withdrawAction = UIAlertAction(
            title: "탈퇴하기",
            style: .destructive) { [weak self] _ in
                self?.viewModel.send(action: .withdraw)
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        [withdrawAction, cancelAction].forEach {
            alertVC.addAction($0)
        }

        present(alertVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return SettingType.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingCell.identifier,
            for: indexPath
        ) as? SettingCell else { return UITableViewCell() }

        let setting = SettingType.allCases[indexPath.row]
        cell.bind(title: setting.title, content: setting.content)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch SettingType.allCases[indexPath.row] {
        case .terms:
            // TODO: 이용약관 뷰로 이동 (ex. 노션, 앱 뷰)
            return

        case .logout:
            presentLogoutActionSheet()
            return

        case .withdraw:
            presentWithdrawActionSheet()
            return

        case .version:
            return
        }
    }
}

extension SettingViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50
    }
}
