//
//  OpenTalkViewController.swift
//  BookTalk
//
//  Created by RAFA on 7/23/24.
//

import UIKit

final class OpenTalkViewController: BaseViewController {

    // MARK: - Properties

    private let bookBanner = UIImageView()
    private let pageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let refreshControl = UIRefreshControl()

    private let viewModel: OpenTalkViewModel

    // MARK: - Initializer

    init(viewModel: OpenTalkViewModel) {
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
        addTarget()

        viewModel.send(action: .loadOpenTalks)
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        let appearance = UINavigationBarAppearance()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let searchIcon = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchIconDidTapped)
        )

        navigationItem.rightBarButtonItem = searchIcon
    }

    override func setViews() {
        bookBanner.do {
            $0.backgroundColor = .gray100
        }

        pageCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.contentInset = .init()
        }

        bookCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 24
            flowLayout.minimumInteritemSpacing = 8

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
            $0.showsVerticalScrollIndicator = false
            $0.refreshControl = refreshControl
        }
    }

    override func setConstraints() {
        [bookBanner, pageCollectionView, bookCollectionView].forEach {
            view.addSubview($0)
        }

        bookBanner.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(190)
        }

        pageCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookBanner.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }

        bookCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Helpers

    private func setDelegate() {
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self

        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
    }

    private func registerCell() {
        pageCollectionView.register(
            OpenTalkPageCell.self,
            forCellWithReuseIdentifier: OpenTalkPageCell.identifier
        )
        bookCollectionView.register(
            BookImageCell.self,
            forCellWithReuseIdentifier: BookImageCell.identifier
        )
    }

    private func addTarget() {
        refreshControl.addTarget(
            self,
            action: #selector(refreshCollectionView),
            for: .valueChanged
        )
    }

    private func bind() {
        viewModel.openTalks.subscribe { [weak self] t in
            self?.bookCollectionView.reloadData()
        }
    }

    // MARK: - Actions

    @objc private func searchIconDidTapped() {
        let searchVC = SearchViewController()

        searchVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchVC, animated: true)
    }

    @objc private func refreshCollectionView() {
        viewModel.send(action: .loadOpenTalks)
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource

extension OpenTalkViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == pageCollectionView {
            return OpenTalkPageType.allCases.count
        } else {
            return viewModel.openTalks.value.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == pageCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OpenTalkPageCell.identifier,
                for: indexPath
            ) as? OpenTalkPageCell else { return UICollectionViewCell() }

            if indexPath.row == 0 {
                collectionView.selectItem(
                    at: indexPath,
                    animated: false,
                    scrollPosition: .init()
                )
                cell.isSelected = true
            }

            cell.bind(OpenTalkPageType.allCases[indexPath.row].title)

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookImageCell.identifier,
                for: indexPath
            ) as? BookImageCell else { return UICollectionViewCell() }

            let openTalk = viewModel.openTalks.value[indexPath.item]
            cell.bind(
                with: Book(
                    isbn: "",
                    imageURL: openTalk.bookImageURL,
                    title: openTalk.bookName
                )
            )
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OpenTalkViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == pageCollectionView {
            return CGSize(width: ScreenSize.width/2, height: collectionView.frame.height)
        } else {
            let width = (ScreenSize.width-36) / 3
            return CGSize(width: width, height: 208)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView == pageCollectionView {
            viewModel.send(action: .setPageType(OpenTalkPageType.allCases[indexPath.item]))
        } else {
            // TODO: 디테일뷰로 이동이지만 임시로 채팅뷰로 바로 이동하도록 구현
            let viewModel = ChatViewModel()
            let chattingVC = ChatViewController(viewModel: viewModel)
            chattingVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(chattingVC, animated: true)
        }
    }
}
