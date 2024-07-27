//
//  CategorySelectModaViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import UIKit

final class CategorySelectModaViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func setViews() {
        view.backgroundColor = .white

        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = CGFloat(20)
            sheetPresentationController.prefersGrabberVisible = true
        }
    }
}
