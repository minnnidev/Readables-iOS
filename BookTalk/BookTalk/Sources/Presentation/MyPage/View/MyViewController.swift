//
//  MyViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

final class MyViewController: BaseViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingButtonDidTapped)
        )

        navigationItem.rightBarButtonItem = settingButton
    }

    // MARK: - Actions

    @objc private func settingButtonDidTapped() {
        let settigVC = SettingViewController()
        settigVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(settigVC, animated: true)
    }
}
