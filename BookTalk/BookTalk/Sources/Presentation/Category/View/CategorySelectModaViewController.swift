//
//  CategorySelectModaViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import UIKit

import SnapKit
import Then

final class CategorySelectModaViewController: BaseViewController {

    private let titleLabel = UILabel()
    private let dismissButton = UIButton()
    private let categoryTableView = UITableView(frame: .zero, style: .plain)
    private let pickerView = UIPickerView()
    private let completeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setPickerView()
        addTarget()
    }

    override func setViews() {
        view.backgroundColor = .white

        guard let sheetPresentationController = sheetPresentationController else { return }
        sheetPresentationController.detents = [.medium()]
        sheetPresentationController.preferredCornerRadius = CGFloat(30)
        sheetPresentationController.prefersGrabberVisible = true

        titleLabel.do {
            $0.text = "카테고리 선택"
            $0.font = .systemFont(ofSize: 25, weight: .semibold)
        }

        dismissButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
        }
        
        pickerView.do {
            $0.backgroundColor = .white
        }

        completeButton.do {
            $0.backgroundColor = .black
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
        }
    }

    override func setConstraints() {
        [titleLabel, dismissButton, pickerView, completeButton].forEach {
            view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(16)
        }

        dismissButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }

        pickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(completeButton.snp.top).offset(-10)
        }

        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(60)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }

    private func setPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    private func addTarget() {
        dismissButton.addTarget(
            self,
            action: #selector(dismissButtonDidTapped),
            for: .touchUpInside
        )
        completeButton.addTarget(
            self, 
            action: #selector(completeButtonDidTapped),
            for: .touchUpInside
        )
    }

    @objc private func dismissButtonDidTapped() {
        dismiss(animated: true)
    }

    @objc private func completeButtonDidTapped() {
        dismiss(animated: true)
    }
}

extension CategorySelectModaViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.secondCategories.count
    }
}

extension CategorySelectModaViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        Category.secondCategories[row]
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        // TODO:
    }
}
