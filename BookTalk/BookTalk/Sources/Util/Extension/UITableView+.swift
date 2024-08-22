//
//  UITableView+.swift
//  BookTalk
//
//  Created by 김민 on 8/21/24.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .lightGray
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 15)
            return label
        }()

        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }
}
