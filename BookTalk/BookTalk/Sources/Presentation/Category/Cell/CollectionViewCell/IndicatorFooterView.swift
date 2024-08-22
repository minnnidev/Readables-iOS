//
//  IndicatorFooterView.swift
//  BookTalk
//
//  Created by 김민 on 8/18/24.
//

import UIKit

final class IndicatorTableViewFooterView: BaseTableViewHeaderFooterView {

    // MARK: - Properties

    private let indicatorView = UIActivityIndicatorView(style: .medium)

    // MARK: - Initializer

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        indicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    override func setConstraints() {
        addSubview(indicatorView)

        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

final class IndicatorFooterView: BaseCollectionViewHeaderFooterView {

    // MARK: - Properties

    private let indicatorView = UIActivityIndicatorView(style: .medium)

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        indicatorView.startAnimating() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    override func setConstraints() {
        addSubview(indicatorView)

        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
