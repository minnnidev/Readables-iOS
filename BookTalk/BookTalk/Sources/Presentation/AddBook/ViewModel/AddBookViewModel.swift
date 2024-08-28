//
//  AddBookViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/13/24.
//

import Foundation

enum AddBookType {
    case readBook
    case goalBook
}

final class AddBookViewModel {

    enum Action {
        case loadFavoriteBooks
        case loadResult(query: String)
        case loadMoreResult(query: String)
        case addToReadBooks(book: Book)
    }

    // MARK: - Properties

    private(set) var books = Observable<[Book]>([])
    private(set) var searchText = Observable("")
    private(set) var loadState = Observable(LoadState.initial)
    private(set) var hasMoreResult = Observable(true)
    private(set) var addBookSucceed = Observable(false)
    private(set) var presentAlert = Observable(false)

    private var currentPage = 1
    private var pageSize = 50

    private let bookName: String?
    private let addBookType: AddBookType

    // MARK: - Initializer

    init(
        addBookType: AddBookType,
        bookName: String? = nil
    ) {
        self.addBookType = addBookType
        self.bookName = bookName

        searchText.value = bookName ?? ""
    }

    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case .loadFavoriteBooks:
            Task {
                do {
                    let favoriteBookResult = try await UserService.getFavoriteBooks()

                    await MainActor.run {
                        books.value = favoriteBookResult
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }

        case let .loadResult(query):
            searchText.value = query
            loadState.value = .loading

            currentPage = 1
            books.value.removeAll()
            hasMoreResult.value = true

            loadResults(query: query, pageNum: currentPage, pageSize: pageSize)

        case let .loadMoreResult(query):
            currentPage += 1
            loadResults(query: query, pageNum: currentPage, pageSize: pageSize)

            return

        case let .addToReadBooks(book):
            Task {
                do {
                    try await BookService.postReadBook(of: book)

                    await MainActor.run {
                        addBookSucceed.value = true
                    }
                } catch let error as NetworkError {
                    switch error {
                    case let .invalidStatusCode(statusCode, message):
                        if statusCode == 400 &&
                            message == "이미 추가된 값입니다" {
                            presentAlert.value = true
                        }
                    default:
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    private func loadResults(
        query: String,
        pageNum: Int,
        pageSize: Int
    ) {
        guard hasMoreResult.value else { return }

        loadState.value = .loading

        Task {
            do {
                let searchResult = try await SearchService.getSearchSimpleRsult(
                    input: query,
                    pageNo: pageNum,
                    pageSize: pageSize
                )

                if searchResult.isEmpty { hasMoreResult.value = false }

                await MainActor.run {
                    books.value.append(contentsOf: searchResult)
                    loadState.value = .completed
                }
            } catch let error as NetworkError {
                print(error.localizedDescription)
                loadState.value = .completed
            }
        }

    }
}
