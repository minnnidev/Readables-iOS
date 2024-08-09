//
//  SearchViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/26/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel = SearchViewModel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var isSearching: Bool = false
    private var searchHistory: [String] = []
    private let historyID = SearchHistoryCell.identifier
    private let resultID = SearchResultCell.identifier
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardNotifications()
        viewModel.input.loadBooks()
        registerCell()
        setDelegate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.output.filteredBooks.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.output.isKeywordSearch.subscribe { [weak self] isKeywordSearch in
            self?.searchBar.placeholder =
                isKeywordSearch ? "키워드를 입력해주세요." : "책 이름 또는 작가 이름을 입력해주세요."
        }
    }
    
    // MARK: - Set UI
    
    override func setNavigationBar() {
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.placeholder = "책 이름 / 작가 이름"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    override func setViews() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.keyboardDismissMode = .interactive
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
    }
    
    override func setConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func registerCell() {
        tableView.do {
            $0.register(SearchHistoryCell.self, forCellReuseIdentifier: historyID)
            $0.register(SearchResultCell.self, forCellReuseIdentifier: resultID)
        }
    }
    
    private func setDelegate() {
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Helpers
    
    private func navigateToBookDetail(with book: DetailBookInfo) {
        let detailViewModel = BookDetailViewModel(bookInfo: book)
        let detailVC = BookDetailViewController()
        detailVC.viewModel = detailViewModel
        detailVC.hidesBottomBarWhenPushed = true
        navigationItem.title = ""
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func setKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        
        let bottomSafeAreaInset = view.safeAreaInsets.bottom
        let keyboardHeight = keyboardFrame.height - bottomSafeAreaInset
        tableView.contentInset.bottom = keyboardHeight
        tableView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        tableView.contentInset.bottom = 0
        tableView.verticalScrollIndicatorInsets.bottom = 0
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let hasFilteredBooks = !viewModel.output.filteredBooks.value.isEmpty
        let hasSearchHistory = !searchHistory.isEmpty
        
        if hasFilteredBooks {
            return viewModel.output.filteredBooks.value.count
        } else if hasSearchHistory {
            return searchHistory.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.output.filteredBooks.value.isEmpty {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: historyID,
                for: indexPath
            ) as? SearchHistoryCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if searchHistory.isEmpty {
                cell.bind("최근 검색어가 없습니다.")
            } else {
                cell.delegate = self
                cell.bind(searchHistory[indexPath.row])
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: resultID,
                for: indexPath
            ) as? SearchResultCell else {
                return UITableViewCell()
            }
            let book = viewModel.output.filteredBooks.value[indexPath.row]
            cell.delegate = self
            cell.selectionStyle = .none
            cell.bind(book)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !viewModel.output.filteredBooks.value.isEmpty {
            let selectedBook = viewModel.output.filteredBooks.value[indexPath.row]
            navigateToBookDetail(with: selectedBook)
        } else if !searchHistory.isEmpty {
            let selectedHistory = searchHistory[indexPath.row]
            searchBar.text = selectedHistory
            viewModel.input.searchTextChanged(selectedHistory.lowercased())
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        cell.separatorInset = .zero
        tableView.separatorStyle =
            viewModel.output.filteredBooks.value.isEmpty && searchHistory.isEmpty ? 
                .none : .singleLine
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.input.searchTextChanged(searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel.input.searchTextChanged(searchText.lowercased())
            if !searchHistory.contains(searchText) {
                searchHistory.append(searchText)
            }
        }
    }
}

// MARK: - SearchHistoryCellDelegate

extension SearchViewController: SearchHistoryCellDelegate {
    
    func didTapDeleteButton(cell: SearchHistoryCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        searchHistory.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

// MARK: - SearchCellDelegate

extension SearchViewController: SearchResultCellDelegate {
    
    func searchResultCell(_ cell: SearchResultCell, didSelectBook book: DetailBookInfo) {
        navigateToBookDetail(with: book)
    }
}
