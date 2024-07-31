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
