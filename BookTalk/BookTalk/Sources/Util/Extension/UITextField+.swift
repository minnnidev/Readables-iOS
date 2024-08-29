//
//  UITextField+.swift
//  BookTalk
//
//  Created by 김민 on 8/29/24.
//

import UIKit

extension UITextField {

    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(
            x: 0, 
            y: 0, 
            width: 5,
            height: self.frame.height)
        )
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
