//
//  UIColor+.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import UIKit.UIColor

extension UIColor {

    convenience init(hex: UInt, alpha: Double = 1) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            alpha: alpha
        )
    }
}

extension UIColor {

    // MARK: Core

    static let accentGreen: UIColor = .init(hex: 0x2B7746)
    static let bubbleGreen: UIColor = .init(hex: 0xDBF1E3)

    // MARK: Grayscale

    static let gray100: UIColor = .init(hex: 0xDBDBDB)
}
