//
//  AddBookViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import UIKit

final class AddBookViewController: BaseViewController {

    // MARK: - Properties

    private let searchBar = UISearchBar()
    private let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let indicatorView = UIActivityIndicatorView(style: .medium)

    private let viewModel: AddBookViewModel

    // MARK: - Initializer

    init(viewModel: AddBookViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        registerCell()
        bind()

        viewModel.send(action: .loadFavoriteBooks)
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.titleView = searchBar
    }

    override func setViews() {
        view.backgroundColor = .white

        searchBar.do {
            $0.placeholder = "어떤 책을 읽고 계신가요?"
        }

        resultCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 24
            flowLayout.minimumInteritemSpacing = 8

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.showsVerticalScrollIndicator = false
        }

        indicatorView.do {
            $0.hidesWhenStopped = true
        }
    }

    override func setConstraints() {
        [searchBar, resultCollectionView, indicatorView].forEach {
            view.addSubview($0)
        }

        resultCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self

        searchBar.delegate = self
    }

    private func registerCell() {
        resultCollectionView.register(
            BookImageCell.self,
            forCellWithReuseIdentifier: BookImageCell.identifier
        )

        resultCollectionView.register(
            LikedTitleHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: LikedTitleHeaderView.identifier
        )
    }

    private func bind() {
        viewModel.favoriteBooks.subscribe { [weak self] _ in
            self?.resultCollectionView.reloadData()
        }

        viewModel.books.subscribe { [weak self] _ in
            self?.resultCollectionView.reloadData()
        }

        viewModel.searchText.subscribe { [weak self] text in
            self?.searchBar.text = text
        }

        viewModel.loadState.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial:
                break

            case .loading:
                indicatorView.startAnimating()
                
            case .completed:
                indicatorView.stopAnimating()

                if viewModel.favoriteBooks.value.isEmpty {
                    resultCollectionView.setEmptyMessage("검색 결과가 없습니다.")
                } else {
                    resultCollectionView.restore()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AddBookViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.favoriteBooks.value.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookImageCell.identifier,
            for: indexPath
        ) as? BookImageCell else { return UICollectionViewCell() }

        cell.bind(with: viewModel.favoriteBooks.value[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddBookViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (ScreenSize.width-36) / 3
        return CGSize(width: width, height: 208)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: LikedTitleHeaderView.identifier,
            for: indexPath
        ) as? LikedTitleHeaderView else { return UICollectionReusableView() }

        return headerView
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if viewModel.loadState.value == .initial {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return .zero
        }
    }
}

// MARK: - UISearchBarDelegate

extension AddBookViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.send(action: .loadResult(query: searchBar.text ?? ""))
    }
}
