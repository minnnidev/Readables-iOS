//
//  ThirdCategoryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 7/27/24.
//

import Foundation

final class AllBooksViewModel {

    // MARK: - Properties

    var books = Observable<[Book]>([])

    private let genreCode: String

    // MARK: - Initializer

    init(genreCode: String) {
        self.genreCode = genreCode
    }

    // MARK: - Helpers

    enum Action {
        case sort(_ sortType: BookSortType)
    }

    func send(action: Action) {
        switch action {
        case let .sort(sortType):
            loadBooks(of: sortType)
        }
    }

    private func loadBooks(of type: BookSortType) {
        switch type {
        case .popularityPerWeek, .popularityPerMonth:
            Task {
                do {
                    let popularBooks = try await GenreService.getBooksByFilter(
                        of: type,
                        with: .init(genreCode: genreCode ,pageNo: "1",pageSize: "10")
                    )

                    await MainActor.run {
                        books.value = popularBooks
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }

        case .newest:
            Task {
                do {
                    let popularBooks = try await GenreService.getNewTrend(
                        with: .init(
                            genreCode: genreCode,
                            pageNo: "1",
                            pageSize: "10"
                        )
                    )

                    await MainActor.run {
                        books.value = popularBooks
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }

        case .random:
            Task {
                do {
                    let popularBooks = try await GenreService.getRandomBooks(
                        with: .init(genreCode: genreCode, maxSize: "10")
                    )

                    await MainActor.run {
                        books.value = popularBooks
                    }
                } catch let error as NetworkError {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
