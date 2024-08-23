//
//  MyLibraryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

final class MyLibraryViewModel {
    private(set) var myLibrary = Observable<[LibraryInfo]>([])

    enum Action {
        case loadMyLibraries
    }

    func send(action: Action) {
        switch action {
        case .loadMyLibraries:
            return
        }
    }
}
