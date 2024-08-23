//
//  MyLibraryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

final class MyLibraryViewModel {
    private(set) var myLibraries = Observable<[LibraryInfo]>([])
    private(set) var loadState = Observable(LoadState.initial)

    enum Action {
        case loadMyLibraries
        case deleteMyLibraries(index: Int)
        case editMyLibraries(newLibraries: [LibraryInfo])
    }

    func send(action: Action) {
        switch action {
        case .loadMyLibraries:
            loadState.value = .loading

            Task {
                do {
                    let libraries = try await UserService.getUserLibraries()

                    await MainActor.run {
                        myLibraries.value = libraries
                        loadState.value = .completed
                    }
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }

        case let .deleteMyLibraries(index):
            myLibraries.value.remove(at: index)

        case let .editMyLibraries(newLibraries):
            Task {
                do {
                    let _ = try await UserService.editUserLibraries(newLibraries: newLibraries)

                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
