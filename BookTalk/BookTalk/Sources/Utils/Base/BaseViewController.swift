//
//  BaseViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setViews()
        setConstraints()
    }

    /// navigation bar 설정
    func setNavigationBar() { }

    /// view attributes 설정
    func setViews() {
        view.backgroundColor = .white
    }

    /// view hierarchy, constraints 설정
    func setConstraints() { }
}
