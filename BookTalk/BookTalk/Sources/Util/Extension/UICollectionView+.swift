//
//  UICollectionView+.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let messageLabel: UILabel = {
                let label = UILabel()
                label.text = message
                label.textColor = .lightGray
                label.numberOfLines = 0
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 15)
                return label
            }()

            self?.backgroundView = messageLabel
        }
    }

    func restore() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundView = nil
        }
    }
}
