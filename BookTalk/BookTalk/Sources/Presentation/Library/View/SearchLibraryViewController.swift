//
//  SearchLibraryViewController.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import UIKit

final class SearchLibraryViewController: BaseViewController {

    // MARK: - Properties

    private let regionTextField = UITextField()
    private let detailRegionTextField = UITextField()
    private let regionPicker = UIPickerView()
    private let detailRegionPicker = UIPickerView()
    private let libraryTableView = UITableView()
    private let indicatorView = UIActivityIndicatorView(style: .medium)

    private let viewModel = SearchLibraryViewModel()

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setToolBar()
        registerCell()
        bind()
    }

    private func bind() {
        viewModel.selectedRegion.subscribe { [weak self] regionType in
            guard let regionType = regionType else { return }

            self?.regionTextField.text = regionType.name
        }

        viewModel.selectedDetailRegion.subscribe { [weak self] detailRegionType in
            guard let detailRegionType = detailRegionType else { return }

            self?.detailRegionTextField.text = detailRegionType.name
        }

        viewModel.searchEnableState.subscribe { [weak self] state in
            guard let self = self else { return }
            guard state else { return }

           viewModel.send(
                action: .loadLibraryResult(
                    region: viewModel.selectedRegion.value,
                    detailRegion: viewModel.selectedDetailRegion.value
                )
            )
        }

        viewModel.libraryResult.subscribe { [weak self] _ in
            self?.libraryTableView.reloadData()
        }

        viewModel.loadState.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial:
                libraryTableView.setEmptyMessage("도서관을 검색해 주세요.")

            case .loading:
                indicatorView.startAnimating()

            case .completed:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    indicatorView.stopAnimating()

                    if viewModel.libraryResult.value.isEmpty {
                        libraryTableView.setEmptyMessage("검색된 도서관이 없습니다.")
                    } else {
                        libraryTableView.restore()
                    }
                }
            }
        }
    }

    // MARK: - UI Setup

    override func setNavigationBar() {
        navigationItem.title = "도서관 추가"
    }

    override func setViews() {
        view.backgroundColor = .white

        regionTextField.do {
            $0.inputView = regionPicker
            $0.borderStyle = .roundedRect
            $0.placeholder = "지역 선택"
            $0.tintColor = .black
        }

        detailRegionTextField.do {
            $0.inputView = detailRegionPicker
            $0.borderStyle = .roundedRect
            $0.placeholder = "세부 지역 선택"
            $0.tintColor = .black
        }

        libraryTableView.do {
            $0.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
            $0.backgroundColor = .clear
            $0.rowHeight = UITableView.automaticDimension
        }

        indicatorView.do {
            $0.hidesWhenStopped = true
        }
    }

    override func setConstraints() {
        [regionTextField, detailRegionTextField, libraryTableView, indicatorView].forEach {
            view.addSubview($0)
        }

        regionTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        detailRegionTextField.snp.makeConstraints {
            $0.top.equalTo(regionTextField.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        libraryTableView.snp.makeConstraints {
            $0.top.equalTo(detailRegionTextField.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        indicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )

        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()

        regionTextField.inputAccessoryView = toolBar
        detailRegionTextField.inputAccessoryView = toolBar
    }

    // MARK: - Helpers

    private func setDelegate() {
        regionPicker.dataSource = self
        regionPicker.delegate = self

        detailRegionPicker.dataSource = self
        detailRegionPicker.delegate = self

        libraryTableView.dataSource = self
        libraryTableView.delegate = self
    }

    private func registerCell() {
        libraryTableView.register(
            LibraryCell.self,
            forCellReuseIdentifier: LibraryCell.identifier
        )
    }

    @objc private func doneButtonDidTapped() {
        if regionTextField.isFirstResponder {
            regionTextField.resignFirstResponder()
            
            guard viewModel.selectedRegion.value == nil else { return }

            viewModel.send(action: .selectRegion(region: RegionType.allCases[0]))
        }

        if detailRegionTextField.isFirstResponder {
            detailRegionTextField.resignFirstResponder()

            guard viewModel.selectedDetailRegion.value == nil else { return }

            viewModel.send(
                action: .selectDetailRegion(detailRegion: DetailRegionType.allCases[0])
            )
        }
    }
}

// MARK: - UIPickerViewDataSource

extension SearchLibraryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            if pickerView == regionPicker {
                return RegionType.allCases.count
            } else if pickerView == detailRegionPicker {
                return DetailRegionType.allCases.count
            }
            return 0
    }
}

// MARK: - UIPickerViewDelegate

extension SearchLibraryViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        if pickerView == regionPicker {
            return RegionType.allCases[row].name
        } else if pickerView == detailRegionPicker {
            return DetailRegionType.allCases[row].name
        }

        return nil
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        if pickerView == regionPicker {
            viewModel.send(action: .selectRegion(region: RegionType.allCases[row]))
        } else if pickerView == detailRegionPicker {
            viewModel.send(action: .selectDetailRegion(detailRegion: DetailRegionType.allCases[row]))
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchLibraryViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.libraryResult.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LibraryCell.identifier,
            for: indexPath
        ) as? LibraryCell else { return UITableViewCell() }

        cell.bind(with: viewModel.libraryResult.value[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchLibraryViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // TODO: 수정 api 호출
    }
}
