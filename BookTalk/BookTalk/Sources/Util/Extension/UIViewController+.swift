//
//  UIViewController+.swift
//  BookTalk
//
//  Created by 김민 on 8/26/24.
//

import UIKit

extension UIViewController {

    func showAutoDismissAlert(
        title: String,
        message: String? = nil,
        dismissAfter seconds: Double = 3.0
    ) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        present(alertVC, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                alertVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}
