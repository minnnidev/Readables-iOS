//
//  EditLibraryViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class EditLibraryViewController: BaseViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    
    @objc private func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Set UI
    
    override func setNavigationBar() {
        navigationItem.title = "도서관 편집"
        
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
