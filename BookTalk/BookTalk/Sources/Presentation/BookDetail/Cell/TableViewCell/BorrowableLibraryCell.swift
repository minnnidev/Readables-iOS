//
//  BorrowableLibraryCell.swift
//  BookTalk
//
//  Created by RAFA on 8/5/24.
//

import UIKit

protocol BorrowableLibraryCellDelegate: AnyObject {
    func pushToMyLibraryVC()
}

final class BorrowableLibraryCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: BorrowableLibraryCellDelegate?
    
    private let titleLabel = UILabel()
    private let libraryStackView = UIStackView()
    private let registerLibraryButton = UIButton(type: .system)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func pushToMyLibraryVC() {
        delegate?.pushToMyLibraryVC()
    }
    
    private func addTargets() {
        registerLibraryButton.addTarget(
            self,
            action: #selector(pushToMyLibraryVC),
            for: .touchUpInside
        )
    }
    
    // MARK: - Bind
    
    func bind(_ viewModel: BookDetailViewModel) {
        viewModel.output.borrowableLibraries.subscribe { [weak self] libraries in
            guard let self = self else { return }
            
            if let libraries = libraries, !libraries.isEmpty {
                registerLibraryButton.isHidden = true
                updateLibraries(libraries)
            } else {
                registerLibraryButton.isHidden = false
                libraryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            }
        }
    }
    
    // MARK: - Helpers
    
    private func updateLibraries(_ libraries: [Library]) {
        libraryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        libraries.forEach { library in
            let label = UILabel()
            label.textAlignment = .left
            label.attributedText = createAttributedText(library)
            libraryStackView.addArrangedSubview(label)
        }
    }
    
    private func createAttributedText(_ library: Library) -> NSAttributedString {
        let libraryNameAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 15, weight: .medium)
        ]
        
        let availabilityAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: library.isAvailable ? UIColor.systemGreen : UIColor.systemRed,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        
        let attributedText = NSMutableAttributedString(
            string: "\(library.name) : ",
            attributes: libraryNameAttributes
        )
        let availabilityText = NSAttributedString(
            string: library.isAvailable ? "대출 가능" : "대출 불가능",
            attributes: availabilityAttributes
        )
        
        attributedText.append(availabilityText)
        return attributedText
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        titleLabel.do {
            $0.text = "대출 가능한 내 도서관"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 25, weight: .bold)
        }
        
        libraryStackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 5
        }
        
        registerLibraryButton.do {
            $0.backgroundColor = .black
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.setTitle("도서관 등록하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        }
    }
    
    override func setConstraints() {
        [titleLabel, libraryStackView, registerLibraryButton].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.top.left.equalToSuperview().inset(15)
        }
        
        libraryStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.left.equalTo(15)
        }
        
        registerLibraryButton.snp.makeConstraints {
            $0.centerX.left.equalTo(libraryStackView)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
