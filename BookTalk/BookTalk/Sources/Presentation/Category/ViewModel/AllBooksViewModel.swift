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
    private(set) var hasMoreResult = Observable(true)

    private var currentPage = 1
    private var pageSize = 18
    private var maxListSize = 50

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
            hasMoreResult.value = true
            books.value.removeAll()

            loadBooks(of: sortType)

        case let .loadMoreBooks(sortType):
            loadBooks(of: sortType)
        }
    }

    private func loadBooks(of type: BookSortType) {
        guard hasMoreResult.value else { return }

        Task {
            do {
                let result = try await fetchBooks(of: type)
                await updateBooks(with: result, of: selectedFilter)
            } catch let error as NetworkError {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    private func fetchBooks(of type: BookSortType) async throws -> [Book] {
        switch type {
        case .popularityPerWeek, .popularityPerMonth:
            return try await GenreService.getBooksByFilter(
                of: type,
                with: .init(
                    genreCode: genreCode,
                    pageNo: "\(currentPage)",
                    pageSize: "\(pageSize)"
                )
            )
        case .newest:
            return try await GenreService.getNewTrend(
                with: .init(
                    genreCode: genreCode,
                    pageNo: "\(currentPage)",
                    pageSize: "\(pageSize)"
                )
            )
        case .random:
            return try await GenreService.getRandomBooks(
                with: .init(
                    genreCode: genreCode,
                    maxSize: "\(maxListSize)"
                )
            )
        }
    }

    @MainActor
    private func updateBooks(with result: [Book], of selectedFilter: BookSortType) {
        if result.isEmpty || result.count < pageSize || selectedFilter == .random {
            hasMoreResult.value = false
        }
        
        books.value.append(contentsOf: result)
        currentPage += 1
    }
}
