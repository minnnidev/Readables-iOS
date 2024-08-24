//
//  MyPageStickyTabView.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

import SnapKit

protocol MyPageStickyTabViewDelegate: AnyObject {
    func didSelectTab(index: Int)
}

final class MyPageStickyTabView: BaseCollectionViewHeaderFooterView {
    
    // MARK: - Properties
    
    weak var delegate: MyPageStickyTabViewDelegate?

    private let finishedBookButton = UIButton(type: .system)
    private let favoriteBookButton = UIButton(type: .system)
    private let tabsStackView = UIStackView()
    private let selectionIndicatorView = UIView()
    private var selectionIndicatorLeadingConstraint: Constraint?
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        let selectedTabIndex = sender.tag
        feedbackGenerator.impactOccurred()
        delegate?.didSelectTab(index: selectedTabIndex)
    }

    // MARK: - Helpers

    func bind(readCnt: Int, dibCnt: Int) {
        finishedBookButton.setTitle("읽은 책 \(readCnt)", for: .normal)
        favoriteBookButton.setTitle("찜한 책 \(dibCnt)", for: .normal)
    }

    func setSelectedTab(index: Int) {
        updateTabSelection(to: index, animated: false)
    }
    
    private func updateTabSelection(to index: Int, animated: Bool) {
        let indicatorPosition = (bounds.width / 2) * CGFloat(index)
        selectionIndicatorLeadingConstraint?.update(offset: indicatorPosition)
        
        let updateUI = {
            self.finishedBookButton.setTitleColor(index == 0 ? .black : .lightGray, for: .normal)
            self.favoriteBookButton.setTitleColor(index == 1 ? .black : .lightGray, for: .normal)
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: updateUI)
        } else {
            updateUI()
        }
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        finishedBookButton.do {
            $0.setTitle("읽은 책", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.tag = 0
            $0.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        }
        
        favoriteBookButton.do {
            $0.setTitle("찜한 책", for: .normal)
            $0.setTitleColor(.lightGray, for: .normal)
            $0.tag = 1
            $0.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        }
        
        selectionIndicatorView.backgroundColor = .accentOrange
        
        tabsStackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.addArrangedSubview(finishedBookButton)
            $0.addArrangedSubview(favoriteBookButton)
        }
    }
    
    override func setConstraints() {
        [tabsStackView, selectionIndicatorView].forEach { addSubview($0) }
        
        tabsStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        selectionIndicatorView.snp.makeConstraints {
            $0.bottom.equalTo(tabsStackView.snp.bottom)
            $0.height.equalTo(2)
            $0.width.equalToSuperview().dividedBy(2)
            selectionIndicatorLeadingConstraint = $0.leading.equalToSuperview().constraint
        }
    }
}
