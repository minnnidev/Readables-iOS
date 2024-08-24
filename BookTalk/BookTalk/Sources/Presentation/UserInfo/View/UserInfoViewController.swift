//
//  UserInfoViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/22/24.
//

import UIKit

final class UserInfoViewController: BaseViewController {

    // MARK: - Properties
    
    private var viewModel = UserInfoViewModel()
    private var isKeyboardAlreadyShown = false
    
    private let addPhotoButton = UIButton(type: .system)
    private let nicknameTextField = UITextField()
    private let maleButton = UIButton(type: .system)
    private let femaleButton = UIButton(type: .system)
    private let selectGenderButtonStackView = UIStackView()
    private let birthTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let signUpButton = UIButton(type: .system)
    private let credentialsStackView = UIStackView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        bind()
        registerKeyboardNotifications()
        setToolBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc private func addPhotoButtonTapped() {
        presentImagePickerActionSheet()
    }
    
    @objc private func nicknameChanged() {
        viewModel.updateNickname(nicknameTextField.text ?? "")
    }
    
    @objc private func selectMaleGender() {
        viewModel.updateGender(.man)
    }

    @objc private func selectFemaleGender() {
        viewModel.updateGender(.woman)
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        viewModel.updateBirthDate(sender.date)
    }
    
    @objc private func doneButtonHandler() {
        birthTextField.attributedText = dateFormat(date: datePicker.date)
        viewModel.updateBirthDate(datePicker.date)
        birthTextField.resignFirstResponder()
    }

    @objc private func registerButtonDidTapped() {
        viewModel.registerUserInfo(
            nickname: viewModel.nickname.value,
            gender: viewModel.selectedGender.value ?? .man,
            birth: DateFormatter.koreanDateFormat.string(
                from: viewModel.birthDate.value ?? Date()
            )
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
//        if !isKeyboardAlreadyShown {
//            UIView.animate(withDuration: 0.3) {
//                self.view.backgroundColor = .black.withAlphaComponent(0.2)
//                self.addPhotoButton.alpha = 0.2
//                self.view.bringSubviewToFront(self.credentialsStackView)
//            }
//            isKeyboardAlreadyShown = true
//        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
//        UIView.animate(withDuration: 0.3) {
//            self.view.backgroundColor = .white
//            self.addPhotoButton.alpha = 1
//        }
//        isKeyboardAlreadyShown = false
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func addTargets() {
        addPhotoButton.addTarget(
            self,
            action: #selector(addPhotoButtonTapped),
            for: .touchUpInside
        )
        nicknameTextField.addTarget(
            self,
            action: #selector(nicknameChanged),
            for: .editingChanged
        )
        maleButton.addTarget(
            self,
            action: #selector(selectMaleGender),
            for: .touchUpInside)
        femaleButton.addTarget(
            self,
            action: #selector(selectFemaleGender),
            for: .touchUpInside
        )
        datePicker.addTarget(
            self,
            action: #selector(dateChanged),
            for: .valueChanged
        )
        signUpButton.addTarget(
            self,
            action: #selector(registerButtonDidTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.nickname.subscribe { [weak self] nickname in
            self?.nicknameTextField.text = nickname
        }

        viewModel.selectedGender.subscribe { [weak self] gender in
            self?.updateGenderSelection(gender)
        }
        
        viewModel.birthDate.subscribe { [weak self] date in
            self?.birthTextField.attributedText = self?.dateFormat(date: date)
        }
        
        viewModel.isFormValid.subscribe { [weak self] isValid in
            self?.updateSignUpButtonState(isValid: isValid)
        }
    }
    
    // MARK: - Helpers
    
    private func updateGenderSelection(_ gender: GenderType?) {
        maleButton.backgroundColor = gender == .man ?
            .accentOrange : .accentOrange.withAlphaComponent(0.2)
        femaleButton.backgroundColor = gender ==
            .woman ? .accentOrange : .accentOrange.withAlphaComponent(0.2)
    }
    
    private func dateFormat(date: Date?) -> NSAttributedString {
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            let dateString = formatter.string(from: date)
            return NSAttributedString(
                string: dateString,
                attributes: [.foregroundColor: UIColor.label]
            )
        } else {
            return NSAttributedString(
                string: "생일을 선택해주세요.",
                attributes: [.foregroundColor: UIColor.gray100]
            )
        }
    }
    
    private func updateSignUpButtonState(isValid: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.signUpButton.isEnabled = isValid
            self.signUpButton.backgroundColor = isValid ?
                .accentOrange : .accentOrange.withAlphaComponent(0.2)
            self.signUpButton.setTitleColor(
                isValid ? .white : .systemBackground.withAlphaComponent(0.7),
                for: .normal
            )
        }
    }

    // MARK: - Set UI
    
    override func setNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "정보 등록"

    }
    
    override func setViews() {
        view.backgroundColor = .white
        
        addPhotoButton.do {
            $0.setImage(
                UIImage(systemName: "plus")?
                    .withTintColor(.gray100, renderingMode: .alwaysOriginal)
                    .withConfiguration(
                        UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
                    ),
                for: .normal
            )
            $0.layer.cornerRadius = 150 / 2
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray100.cgColor
        }
        
        setupTextField(
            textField: nicknameTextField,
            placeholder: "닉네임 (한글 2자 이상, 영어 3자 이상)",
            spacerWidth: 12
        )
        
        setupGenderButton(maleButton, title: "남")
        setupGenderButton(femaleButton, title: "여")
        
        selectGenderButtonStackView.do {
            $0.addArrangedSubview(maleButton)
            $0.addArrangedSubview(femaleButton)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 5
        }
        
        setupTextField(
            textField: birthTextField,
            spacerWidth: 12
        )
        
        birthTextField.do {
            $0.tintColor = .clear
            $0.inputView = datePicker
            $0.delegate = self
        }
        
        datePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.locale = .init(identifier: "ko-KR")
            $0.maximumDate = Date()
        }
        
        signUpButton.do {
            $0.isEnabled = false
            $0.layer.cornerRadius = 10
            $0.setTitle("정보 등록하기", for: .normal)
            $0.setTitleColor(.white.withAlphaComponent(0.7), for: .normal)
            $0.backgroundColor = .accentOrange.withAlphaComponent(0.8)
        }
        
        credentialsStackView.do {
            $0.addArrangedSubview(nicknameTextField)
            $0.addArrangedSubview(selectGenderButtonStackView)
            $0.addArrangedSubview(birthTextField)
            $0.addArrangedSubview(signUpButton)
            $0.axis = .vertical
            $0.spacing = 20
        }
    }
    
    override func setConstraints() {
        [addPhotoButton,
         credentialsStackView].forEach { view.addSubview($0) }
        
        addPhotoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.size.equalTo(150)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        maleButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        credentialsStackView.snp.makeConstraints {
            $0.centerX.equalTo(addPhotoButton)
            $0.top.lessThanOrEqualTo(addPhotoButton.snp.bottom).offset(50)
            $0.left.equalTo(10)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
        }
        
        birthTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension UserInfoViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            addPhotoButton.setImage(
                editedImage.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
        } else if let originalImage = info[.originalImage] as? UIImage {
            addPhotoButton.setImage(
                originalImage.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
        }
        
        addPhotoButton.layer.borderColor = UIColor.clear.cgColor
        addPhotoButton.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate

extension UserInfoViewController: UINavigationControllerDelegate {

    private func presentImagePickerActionSheet() {
        let actionSheet = UIAlertController(
            title: "사진 선택",
            message: "프로필 사진을 선택하세요.",
            preferredStyle: .actionSheet
        )
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            self.presentImagePicker(sourceType: .camera)
        }
        
        let libraryAction = UIAlertAction(title: "사진 앨범", style: .default) { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension UserInfoViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return false
    }
}

// MARK: - Set UI Helpers

private extension UserInfoViewController {

    func setupTextField(textField: UITextField, placeholder: String? = nil, spacerWidth: CGFloat) {
        textField.do {
            $0.textColor = .label
            $0.tintColor = .label
            $0.borderStyle = .none
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray100.cgColor
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            $0.spellCheckingType = .no
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let spacer = UIView(frame: .init(x: 0, y: 0, width: spacerWidth, height: 50))
            $0.leftView = spacer
            $0.leftViewMode = .always
            if let placeholder = placeholder {
                $0.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [.foregroundColor: UIColor.gray100]
                )
            }
        }
    }

    func setupGenderButton(_ button: UIButton, title: String) {
        button.do {
            $0.setAttributedTitle(
                NSAttributedString(
                    string: title,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 15, weight: .medium),
                        .foregroundColor: UIColor.white
                    ]
                ),
                for: .normal
            )
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
    }
    
    func setToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonHandler)
        )
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        birthTextField.inputAccessoryView = toolBar
    }
}
