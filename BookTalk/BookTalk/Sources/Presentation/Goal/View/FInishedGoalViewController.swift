//
//  FInishedGoalViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/30/24.
//

import UIKit

final class FInishedGoalViewController: BaseViewController {

    private let bookImageView = UIImageView()
    private let bookTitlelabel = UILabel()
    private let startReadingDateLabel = UILabel()
    private let endReadingDateLabel = UILabel()
    private let indicatorView = UIActivityIndicatorView(style: .medium)

    private var contentViews: [UIView] = []

    private let viewModel: FinishedGoalViewModel

    init(viewModel: FinishedGoalViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        bind()

        viewModel.send(action: .loadGoalDetail(goalId: viewModel.goalId))
    }

    private func bind() {
        viewModel.goalDetail.subscribe { detail in
            guard let detail = detail else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                bookTitlelabel.text = detail.bookInfo.title
                startReadingDateLabel.text = "시작 날짜: \(detail.startDate)"
                endReadingDateLabel.text = "완독 날짜: \(detail.updateDate)"

                if let imageURL = URL(string: detail.bookInfo.coverImageURL) {
                    bookImageView.kf.setImage(with: imageURL)
                }
            }
        }

        viewModel.deleteSucceed.subscribe { [weak self] isSucceed in
            guard isSucceed else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                showAutoDismissAlert(title: "목표 삭제가 완료되었어요.") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }

        viewModel.loadState.subscribe { state in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch state {
                case .initial:
                    _ = contentViews.map { $0.isHidden = true}
                case .loading:
                    indicatorView.startAnimating()
                case .completed:
                    indicatorView.stopAnimating()
                    _ = contentViews.map { $0.isHidden = false }
                }
            }
        }
    }

    override func setNavigationBar() {
        navigationItem.title = "목표 상세"
        navigationItem.largeTitleDisplayMode = .never

        let menuButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(menuButtonDidTapped)
        )

        navigationItem.rightBarButtonItem = menuButton
    }

    override func setViews() {
        view.backgroundColor = .white

        bookImageView.do {
            $0.backgroundColor = .gray100
        }

        bookTitlelabel.do {
            $0.text = "책 제목"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }

        startReadingDateLabel.do {
            $0.textColor = .accentOrange
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.text = "시작 날짜"
        }

        endReadingDateLabel.do {
            $0.textColor = .accentOrange
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.text = "완독 날짜"
        }

        indicatorView.do {
            $0.hidesWhenStopped = true
        }
    }

    override func setConstraints() {
        [
            bookImageView, bookTitlelabel,
            startReadingDateLabel, endReadingDateLabel
        ].forEach {
            view.addSubview($0)
            contentViews.append($0)
        }

        view.addSubview(indicatorView)

        bookImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }

        bookTitlelabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(4)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        startReadingDateLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitlelabel.snp.bottom).offset(8)
            $0.leading.equalTo(bookTitlelabel)
        }

        endReadingDateLabel.snp.makeConstraints {
            $0.top.equalTo(startReadingDateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bookTitlelabel)
        }

        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc private func menuButtonDidTapped() {
        let alertVC = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let deleteAction = UIAlertAction(
            title: "목표 삭제",
            style: .destructive) { [weak self] _ in
                guard let self = self else { return }

                viewModel.send(action: .deleteGoal(goalId: viewModel.goalId))
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        [deleteAction, cancelAction].forEach {
            alertVC.addAction($0)
        }

        present(alertVC, animated: true)
    }
}
