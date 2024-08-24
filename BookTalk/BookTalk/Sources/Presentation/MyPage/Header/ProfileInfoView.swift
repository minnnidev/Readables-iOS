//
//  ProfileInfoView.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class ProfileInfoView: BaseCollectionViewHeaderFooterView {
    
    // MARK: - Properties

    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let genderAndAgeLabel = UILabel()
    private let userInfoStackView = UIStackView()
    private let libraryTextStackView = UIStackView()
    private let addFinishedBookButton = UIButton(type: .system)
    private let editLibraryButton = UIButton(type: .system)
    private let profileBottomButtons = UIStackView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTargets()
        addGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func addFinishedBookButtonTapped() {
        // TODO:
    }
    
    @objc private func editLibraryButtonTapped() {
        // TODO: 
    }
    
    @objc private func imageViewTapped() {
        let fullScreen = FullScreenViewController()
        fullScreen.modalTransitionStyle = .crossDissolve
        fullScreen.modalPresentationStyle = .overFullScreen
        fullScreen.image = profileImageView.image
        window?.rootViewController?.present(fullScreen, animated: true)
    }
    
    private func addTargets() {
        addFinishedBookButton.addTarget(
            self,
            action: #selector(addFinishedBookButtonTapped),
            for: .touchUpInside
        )
        editLibraryButton.addTarget(
            self,
            action: #selector(editLibraryButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Bind
    
    func bind() {
        
//        viewModel.output.profileImage.subscribe { [weak self] image in
//            self?.profileImageView.image = image
//        }
//        
//        viewModel.output.name.subscribe { [weak self] name in
//            self?.nameLabel.text = name
//        }
//        
//        viewModel.output.genderAgeText.subscribe { [weak self] text in
//            self?.genderAndAgeLabel.text = text
//        }
//        
//        viewModel.output.addedTexts.subscribe { [weak self] texts in
//            self?.displayAddedTexts(texts)
//            self?.invalidateCollectionViewLayout()
//        }
    }
    
    // MARK: - Helpers
    
    private func displayAddedTexts(_ texts: [String]) {
        libraryTextStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        texts.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 15)
            libraryTextStackView.addArrangedSubview(label)
        }
        
        self.invalidateCollectionViewLayout()
    }
    
    private func invalidateCollectionViewLayout() {
        if let collectionView = self.superview as? UICollectionView {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        profileImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 180 / 2
            $0.backgroundColor = #colorLiteral(red: 0.8912894652, green: 0.8912894652, blue: 0.8912894652, alpha: 1)
            $0.tintColor = .white
            $0.contentMode = .scaleAspectFill
            $0.isUserInteractionEnabled = true
        }
        
        nameLabel.do {
            $0.text = "애벌레"
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        genderAndAgeLabel.do {
            $0.text = "남"
            $0.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            $0.font = .systemFont(ofSize: 15, weight: .medium)
            $0.numberOfLines = 1
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        userInfoStackView.do {
            $0.addArrangedSubview(nameLabel)
            $0.addArrangedSubview(genderAndAgeLabel)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillProportionally
            $0.spacing = 5
        }
        
        libraryTextStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 5
        }
        
        addFinishedBookButton.do {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "books.vertical")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 13, weight: .medium))
            config.imagePadding = 5
            config.imagePlacement = .leading
            config.attributedTitle = AttributedString(
                NSAttributedString(
                    string: "읽은 책 추가",
                    attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]
                )
            )
            config.baseForegroundColor = .black
            $0.configuration = config
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .accentOrange.withAlphaComponent(0.2)
        }
        
        editLibraryButton.do {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "building.columns")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 13, weight: .medium))
            config.imagePadding = 5
            config.imagePlacement = .leading
            config.baseForegroundColor = .black
            config.attributedTitle = AttributedString(
                NSAttributedString(
                    string: "도서관 편집",
                    attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]
                )
            )
            $0.configuration = config
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        }
        
        profileBottomButtons.do {
            $0.addArrangedSubview(addFinishedBookButton)
            $0.addArrangedSubview(editLibraryButton)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 5
        }
    }
    
    override func setConstraints() {
        [profileImageView, userInfoStackView, libraryTextStackView,  profileBottomButtons].forEach {
            addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.size.equalTo(180)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.centerX.equalTo(profileImageView)
            $0.top.equalTo(profileImageView.snp.bottom).offset(5)
            $0.left.greaterThanOrEqualTo(15)
        }
        
        libraryTextStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userInfoStackView.snp.bottom).offset(10)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
        
        addFinishedBookButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        profileBottomButtons.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(libraryTextStackView.snp.bottom).offset(10)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.bottom.greaterThanOrEqualTo(-10)
        }
    }
}
