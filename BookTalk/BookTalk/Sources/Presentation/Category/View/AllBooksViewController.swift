//
//  ThirdCategoryViewController.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

final class AllBooksViewController: BaseViewController {

    // MARK: - Properties

    private let sortView = UIView()
    private let sortButton = UIButton()
    private let booksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let viewModel: AllBooksViewModel

    // MARK: - Initializer

    init(viewModel: AllBooksViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setCollectionView()
        bind()

        viewModel.send(action: .sort(.popularityPerWeek))
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "전체 보기"
    }

    override func setViews() {
        view.backgroundColor = .white

        sortView.do {
            $0.backgroundColor = .white
        }

        sortButton.do {
            $0.setTitle("일주일 인기순", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.tintColor = .black
            $0.showsMenuAsPrimaryAction = true
            $0.menu = UIMenu(children: createMenus())
        }

        booksCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 24
            flowLayout.minimumInteritemSpacing = 8

            $0.collectionViewLayout = flowLayout
            $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.showsVerticalScrollIndicator = false
        }
    }

    override func setConstraints() {
        [sortButton].forEach {
            sortView.addSubview($0)
        }

        [sortView, booksCollectionView].forEach {
            view.addSubview($0)
        }

        sortButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }

        sortView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }

        booksCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Helpers

    private func registerCell() {
        booksCollectionView.register(BookImageCell.self, forCellWithReuseIdentifier: BookImageCell.identifier)
    }

    private func setCollectionView() {
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
    }

    private func createMenus() -> [UIAction] {
        var actions: [UIAction] = .init()

        BookSortType.allCases.forEach { sortType in
            let action: UIAction = .init(
                title: sortType.title,
                handler: { [weak self] _ in
                    self?.sortButton.setTitle(sortType.title, for: .normal)
                    self?.viewModel.send(action: .sort(sortType))
                }
            )

            actions.append(action)
        }

        return actions
    }

    private func bind() {
        viewModel.books.subscribe { books in
            Task { [weak self] in
                await MainActor.run {
                    self?.booksCollectionView.reloadData()

                    guard books.count > 0 else { return }

                    self?.booksCollectionView.scrollToItem(
                        at: IndexPath(item: 0, section: 0),
                        at: .top,
                        animated: false
                    )
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AllBooksViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.books.value.count
    }

    func collectionView(
        _ collectionView: UICollectionView, 
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookImageCell.identifier,
            for: indexPath
        ) as? BookImageCell else { return UICollectionViewCell() }

        cell.bind(with: viewModel.books.value[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AllBooksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (ScreenSize.width-36) / 3
        return CGSize(width: width, height: 208)
    }
}
