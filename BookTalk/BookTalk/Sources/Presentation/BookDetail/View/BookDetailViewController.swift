//
//  BookDetailViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/2/24.
//

import UIKit

final class BookDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: BookDetailViewModel!
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViews() {
        view.backgroundColor = .white
        
        tableView.do {
            $0.dataSource = self
            $0.separatorInset = .zero
            $0.register(BookInfoCell.self, forCellReuseIdentifier: "BookInfoCell")
            $0.register(NearbyCell.self, forCellReuseIdentifier: "NearbyCell")
        }
    }
    
    override func setConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.centerX.left.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}

// MARK: - UITableViewDataSource

extension BookDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "BookInfoCell",
                for: indexPath
            ) as? BookInfoCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.bind(viewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "NearbyCell",
                for: indexPath
            ) as? NearbyCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}
