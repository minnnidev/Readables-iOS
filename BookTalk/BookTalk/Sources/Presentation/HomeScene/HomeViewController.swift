//
//  HomeViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func searchIconTapped() {
        let searchVC = SearchViewController()
        
        navigationItem.title = ""
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

// MARK: - UI Setup

private extension HomeViewController {
    
    func setupUI() {
        configureNavBar()
        setupConstraints()
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let searchIcon = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchIconTapped)
        )
        
        navigationItem.rightBarButtonItem = searchIcon
    }
    
    func setupConstraints() {
        
    }
}
