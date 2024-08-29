//
//  NotStartedReadingCell.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import UIKit

final class NotStartedReadingCell: BaseTableViewCell {

    // MARK: - Properties

    private let titleLabel = UILabel()
    private let addButton = UIButton()

    var addButtonDidTappedObservable = Observable(false)

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        contentView.backgroundColor = .clear
        
        titleLabel.do {
            $0.text = "나도 같이 읽기 📚"
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
        }

        addButton.do {
            $0.setTitle("목표 추가하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor.accentOrange
            $0.layer.cornerRadius = 10
        }
    }

    override func setConstraints() {
        [titleLabel, addButton].forEach {
            contentView.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.trailing.equalToSuperview().offset(-20)
        }
    }

    // MARK: - Helpers

    private func addTarget() {
        addButton.addTarget(
            self,
            action: #selector(addButtonDidTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    @objc private func addButtonDidTapped() {
        addButtonDidTappedObservable.value = true
    }
}
