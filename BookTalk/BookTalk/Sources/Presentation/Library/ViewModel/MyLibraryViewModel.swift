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
            return
        }
    }
}
