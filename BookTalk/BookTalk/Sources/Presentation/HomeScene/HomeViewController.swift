//
//  HomeViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

import SafeAreaBrush

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
        fillSafeArea(position: .top, color: .accentGreen)
        configureNavBar()
        setupConstraints()
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .accentGreen
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let searchIcon = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchIconTapped)
        )
        
        searchIcon.tintColor = .white
        navigationItem.rightBarButtonItem = searchIcon
    }
    
    func setupConstraints() {
        
    }
}
