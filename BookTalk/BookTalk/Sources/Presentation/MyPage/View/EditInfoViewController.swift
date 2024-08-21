//
//  EditInfoViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class EditInfoViewController: BaseViewController {
    
    // MARK: - Actions
    
    @objc private func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Set UI
    
    override func setNavigationBar() {
        navigationItem.title = "정보 수정"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
    }
    
    override func setViews() {
        view.backgroundColor = .white
    }
}
