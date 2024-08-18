//
//  ThirdCategoryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import Foundation

final class AllBooksViewModel {

    // MARK: - Properties

    private(set) var books = Observable<[Book]>([])
    private var currentPage = 1
    private var pageSize = 18
    private var hasMoreResult = true
    private var isLoading = false

    var selectedFilter = BookSortType.popularityPerWeek

    private let genreCode: String

    // MARK: - Initializer

    init(genreCode: String) {
        self.genreCode = genreCode
    }

    // MARK: - Helpers

    enum Action {
        case loadBooks(_ sortType: BookSortType)
        case loadMoreBooks(_ sortType: BookSortType)
    }

    func send(action: Action) {
        switch action {
        case let .loadBooks(sortType):
            currentPage = 1
            hasMoreResult = true
            books.value.removeAll()

            loadBooks(of: sortType)

        case let .loadMoreBooks(sortType):
            loadBooks(of: sortType)
        }
    }

    private func loadBooks(of type: BookSortType) {
        guard !isLoading && hasMoreResult else { return }

        isLoading = true

        switch type {
        case .popularityPerWeek, .popularityPerMonth:
            Task {
                do {
                    let result = try await GenreService.getBooksByFilter(
                        of: type,
                        with: .init(
                            genreCode: genreCode,
                            pageNo: "\(currentPage)",
                            pageSize: "\(pageSize)")
                    )

                    await MainActor.run {
                        if result.isEmpty {
                            hasMoreResult = false
                        } else {
                            books.value.append(contentsOf: result)
                            currentPage += 1
                        }

                        isLoading = false
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }

        case .newest:
            Task {
                do {
                    let result = try await GenreService.getNewTrend(
                        with: .init(
                            genreCode: genreCode,
                            pageNo: "\(currentPage)",
                            pageSize: "\(pageSize)"
                        )
                    )

                    await MainActor.run {
                        if result.isEmpty {
                            hasMoreResult = false
                        } else {
                            books.value.append(contentsOf: result)
                            currentPage += 1
                        }
                        isLoading = false
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }

        case .random:
            Task {
                do {
                    let result = try await GenreService.getRandomBooks(
                        with: .init(genreCode: genreCode, maxSize: "\(pageSize)")
                    )

                    await MainActor.run {
                        if result.isEmpty {
                            hasMoreResult = false
                        } else {
                            books.value.append(contentsOf: result)
                            currentPage += 1
                        }
                        isLoading = false
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
