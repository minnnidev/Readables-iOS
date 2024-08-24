//
//  BookInfoCell.swift
//  BookTalk
//
//  Created by RAFA on 8/5/24.
//

import UIKit

import Kingfisher

final class BookInfoCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private var viewModel: BookDetailViewModel?
    private let bookImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publicationDateLabel = UILabel()
    private let availabilityLabel = UILabel()
    private let bookInfoStackView = UIStackView()
    private let joinOpenTalkButton = UIButton(type: .system)
    private let markAsReadButton = UIButton(type: .system)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func toggleMarkAsReadButton() {
        viewModel?.input.markAsReadButtonTap()
    }
    
    private func addTargets() {
        markAsReadButton.addTarget(
            self,
            action: #selector(toggleMarkAsReadButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Bind

    func bind(_ viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        
        viewModel.output.detailBook.subscribe { [weak self] detail in
            guard let self = self else { return }
            guard let detail = detail else { return }

            titleLabel.text = detail.basicBookInfo.title
            authorLabel.text = detail.basicBookInfo.author
            publisherLabel.text = detail.publisher
            publicationDateLabel.text = detail.publicationDate
            
            let (availabilityText, availabilityColor) = 
                viewModel.updateAvailability(detail.registeredLibraries)
            self.availabilityLabel.text = availabilityText
            self.availabilityLabel.textColor = availabilityColor
            
            guard let imageURL = URL(string: detail.basicBookInfo.coverImageURL) else { return }
            bookImageView.kf.setImage(with: imageURL)
            
            updateLayout()
        }
        
        viewModel.output.isMarkAsRead.subscribe { [weak self] isMarkedAsRead in
            guard let self = self else { return }
            updateMarkAsReadButton(isMarkedAsRead: isMarkedAsRead)
        }
    }
    
    // MARK: - Helpers
    
    private func updateLayout() {
        if let tableView = superview as? UITableView {
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    private func updateMarkAsReadButton(isMarkedAsRead: Bool) {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.attributedTitle = AttributedString(
            NSAttributedString(
                string: isMarkedAsRead ? "읽은 책에서 삭제하기" : "읽은 책으로 추가하기",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15, weight: .bold),
                    .foregroundColor: isMarkedAsRead ? UIColor.systemRed : UIColor.systemBlue
                ]
            )
        )
        
        config.image = UIImage(systemName: isMarkedAsRead ? "minus" : "plus")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            .withTintColor(
                isMarkedAsRead ? .systemRed : .systemBlue,
                renderingMode: .alwaysOriginal
            )
        
        markAsReadButton.configuration = config
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        bookImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        
        titleLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 23, weight: .bold)
        }
        
        authorLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publisherLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        publicationDateLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        availabilityLabel.do {
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .bold)
        }
        
        bookInfoStackView.do {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(authorLabel)
            $0.addArrangedSubview(publisherLabel)
            $0.addArrangedSubview(publicationDateLabel)
            $0.addArrangedSubview(availabilityLabel)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillProportionally
            $0.spacing = 5
        }
        
        joinOpenTalkButton.do {
            $0.backgroundColor = .accentOrange
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.setTitle("오픈톡 참여하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        }
        
        markAsReadButton.do {
            var config = UIButton.Configuration.plain()
            config.imagePlacement = .trailing
            config.imagePadding = 5
            
            $0.configuration = config
        }
    }
    
    override func setConstraints() {
        [bookImageView,
         bookInfoStackView,
         joinOpenTalkButton,
         markAsReadButton].forEach { contentView.addSubview($0) }
        
        bookImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(15)
            $0.left.equalTo(15)
            $0.height.equalTo(250)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.centerX.left.equalTo(bookImageView)
            $0.top.equalTo(bookImageView.snp.bottom).offset(10)
        }
        
        joinOpenTalkButton.snp.makeConstraints {
            $0.centerX.left.equalTo(bookInfoStackView)
            $0.top.equalTo(bookInfoStackView.snp.bottom).offset(15)
            $0.height.equalTo(50)
        }
        
        markAsReadButton.snp.makeConstraints {
            $0.centerX.left.equalTo(joinOpenTalkButton)
            $0.top.equalTo(joinOpenTalkButton.snp.bottom).offset(15)
            $0.bottom.equalTo(-15)
            $0.height.equalTo(30)
        }
    }
}
