//
//  CategoryBookCell.swift
//  BookTalk
//
//  Created by 김민 on 7/26/24.
//

import UIKit

protocol BookWithHeaderCellDelegate: AnyObject {
    func bookImageTapped()
}

final class BookWithHeaderCell: BaseTableViewCell {

    // MARK: - Properties

    private let headerLabel = UILabel()
    private let bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    weak var delegate: BookWithHeaderCellDelegate?

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        registerCell()
        setCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    override func setViews() {
        selectionStyle = .none
        
        contentView.backgroundColor = .clear

        headerLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
        }

        bookCollectionView.do {
            let flowLayout: UICollectionViewFlowLayout = .init()
            flowLayout.scrollDirection = .horizontal

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
    }

    override func setConstraints() {

        [headerLabel, bookCollectionView].forEach {
            contentView.addSubview($0)
        }

        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(12)
        }

        bookCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(208)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Helpers

    private func registerCell() {
        bookCollectionView.register(BookImageCell.self, forCellWithReuseIdentifier: BookImageCell.identifier)
    }

    private func setCollectionView() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
    }

    func bind(_ model: BooksWithHeader) {
        headerLabel.text = "\(model.headerTitle)"

        // TODO: image bind
    }
}

extension BookWithHeaderCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookImageCell.identifier,
            for: indexPath
        ) as? BookImageCell else { return UICollectionViewCell() }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bookImageTapped()
    }
}

extension BookWithHeaderCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // TODO: 책 사이즈 정의
        return CGSize(width: (ScreenSize.width-36) / 3, height: collectionView.frame.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }
}
