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
        dismissAfter seconds: Double = 1.0,
        completion: (() -> Void)? = nil
    ) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            present(alertVC, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    alertVC.dismiss(animated: true, completion: completion)
                }
            }
        }
    }
}
