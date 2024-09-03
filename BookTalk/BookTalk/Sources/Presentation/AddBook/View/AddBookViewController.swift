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
        navigationItem.largeTitleDisplayMode = .never
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
    }

    override func setConstraints() {
        [searchBar, resultCollectionView].forEach {
            view.addSubview($0)
        }

        resultCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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

        resultCollectionView.register(
            IndicatorFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: IndicatorFooterView.identifier
        )
    }

    @MainActor
    private func bind() {
        viewModel.books.subscribe { [weak self] _ in
            self?.resultCollectionView.reloadData()
        }

        viewModel.searchText.subscribe { [weak self] text in
            self?.searchBar.text = text
        }

        viewModel.loadState.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .completed:
                if viewModel.books.value.isEmpty {
                    resultCollectionView.setEmptyMessage("검색 결과가 없습니다.")
                } else {
                    resultCollectionView.restore()
                }

            case .initial, .loading:
                break

            }
        }

        viewModel.hasMoreResult.subscribe { [weak self] hasMore in
            guard let self = self else { return }

            let indexPath = IndexPath(item: 0, section: 0)
            let context = UICollectionViewFlowLayoutInvalidationContext()
            context.invalidateSupplementaryElements(
                ofKind: UICollectionView.elementKindSectionFooter,
                at: [indexPath]
            )

            DispatchQueue.main.async {
                self.resultCollectionView.collectionViewLayout.invalidateLayout(with: context)
            }
        }

        viewModel.addBookSucceed.subscribe { isSucceed in
            guard isSucceed else { return }

            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }

        viewModel.goalExistAlert.subscribe { [weak self] isExist in
            guard isExist else { return }

            self?.showAutoDismissAlert(title: "이미 완료된 목표로 추가되어 있어요!")
        }

        viewModel.presentAlert.subscribe { [weak self] isPresented in
            guard isPresented else { return }

            self?.showAutoDismissAlert(title: "이미 읽은 책으로 추가되어 있어요!")
        }

        viewModel.presentPageAlert.subscribe { [weak self] isPresented in
            guard isPresented else { return }
            guard let self = self else { return }

            configurePageInputAlert()
        }
    }

    private func configurePageInputAlert() {
        let alertVC = UIAlertController(
            title: "목표 추가",
            message: "총 페이지 수를 입력해 주세요.",
            preferredStyle: .alert
        )

        alertVC.addTextField { tf in
            tf.placeholder = "페이지 수"
            tf.keyboardType = .numberPad
            tf.addTarget(
                self,
                action: #selector(self.textDidChange(_:)),
                for: .editingChanged
            )
        }

        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel,
            handler: nil
        )

        let okAction = UIAlertAction(title: "완료", style: .default) { _ in
            if let textField = alertVC.textFields?.first {
                self.viewModel.send(
                    action: .addToGoalBooks(
                        book: self.viewModel.goalBook,
                        totalPage: textField.text ?? ""
                    )
                )
            }
        }

        okAction.isEnabled = false

        [cancelAction, okAction].forEach { alertVC.addAction($0) }

        present(alertVC, animated: true)
    }

    @objc private func textDidChange(_ textField: UITextField) {
        guard let alertVC = self.presentedViewController as? UIAlertController,
              let okAction = alertVC.actions.last else {
            return
        }
        okAction.isEnabled = !(textField.text?.isEmpty ?? true)
    }
}

// MARK: - UICollectionViewDataSource

extension AddBookViewController: UICollectionViewDataSource {

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

        cell.bind(with: viewModel.books.value[indexPath.item])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let book = viewModel.books.value[indexPath.item]
        viewModel.send(action: .tapBookImage(book: book))
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
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: LikedTitleHeaderView.identifier,
                for: indexPath
            ) as? LikedTitleHeaderView else { return UICollectionReusableView() }

            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: IndicatorFooterView.identifier,
                for: indexPath
            ) as? IndicatorFooterView else { return UICollectionReusableView() }

            return footerView
        }

        return UICollectionReusableView()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard viewModel.hasMoreResult.value else { return .zero }

        if viewModel.loadState.value == .initial {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return .zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard viewModel.hasMoreResult.value else { return .zero }
        guard viewModel.loadState.value == .loading else { return .zero }

        return CGSize(
            width: collectionView.frame.width,
            height: 50
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard viewModel.loadState.value != .initial else { return }

        let isLoadPoint = indexPath.item == viewModel.books.value.count - 9
        guard isLoadPoint else { return }

        viewModel.send(action: .loadMoreResult(query: viewModel.searchText.value))
    }
}

// MARK: - UISearchBarDelegate

extension AddBookViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        viewModel.send(action: .loadResult(query: searchBar.text ?? ""))
    }
}
