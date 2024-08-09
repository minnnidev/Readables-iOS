//
//  GoalViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

final class GoalViewController: BaseViewController {

    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "목표"
    }

    override func setViews() {
        scrollView.do {
            $0.backgroundColor = .clear
        }
    }

    override func setConstraints() {
        [scrollView].forEach {
            view.addSubview($0)
        }

        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
