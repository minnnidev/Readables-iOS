//
//  SearchViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/26/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc private func cancelButtonDidTap() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Set UI
    
    override func setNavigationBar() {
        searchBar.placeholder = "책 이름 / 작가 이름"
        navigationItem.titleView = searchBar
        
        let cancel = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        navigationItem.rightBarButtonItem = cancel
    }
    
    override func setViews() {
        view.backgroundColor = .white
    }
}
