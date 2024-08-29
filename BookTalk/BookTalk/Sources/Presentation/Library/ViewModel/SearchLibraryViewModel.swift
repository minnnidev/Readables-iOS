//
//  SearchLibraryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

final class SearchLibraryViewModel {

    // MARK: - Properties

    private(set) var selectedRegion: Observable<RegionType?> = Observable(nil)
    private(set) var selectedDetailRegion: Observable<DetailRegion?> = Observable(nil)
    private(set) var searchEnableState = Observable(false)
    private(set) var libraryResult = Observable<[LibraryInfo]>([])
    private(set) var loadState = Observable(LoadState.initial)
    private(set) var popToMyLibrary = Observable(false)

    private var myLibraries: [LibraryInfo]

    // MARK: - Initializer

    init(myLibraries: [LibraryInfo]) {
        self.myLibraries = myLibraries 
    }

    // MARK: - Actions

    enum Action {
        case selectRegion(region: RegionType?)
        case selectDetailRegion(detailRegion: DetailRegion?)
        case loadLibraryResult(region: RegionType?, detailRegion: DetailRegion?)
        case editMyLibrary(newLibray: LibraryInfo)
    }


    // MARK: - Helpers

    func send(action: Action) {
        switch action {
        case let .selectRegion(region):
            guard let region = region else { return }
            selectedRegion.value = region
            selectedDetailRegion.value = .none
            updateSearchState()

        case let .selectDetailRegion(detailRegion):
            guard let detailRegion = detailRegion else { return }
            selectedDetailRegion.value = detailRegion
            updateSearchState()

        case let .loadLibraryResult(region, detailRegion):
            guard let region = region else { return }
            guard let detailRegion = detailRegion else { return }

            libraryResult.value.removeAll()
            loadState.value = .loading

            Task {
                do {
                    let libraries = try await LibraryService.getLibrarySearchResult(
                        region: region,
                        detailRegion: detailRegion
                    )

                    await MainActor.run {
                        libraryResult.value = libraries
                        loadState.value = .completed
                    }

                } catch let error as NetworkError {
                    print(error.localizedDescription)
                    loadState.value = .completed
                }
            }

        case let .editMyLibrary(newLibrary):
            myLibraries.append(newLibrary)

            Task {
                do {
                    let _ = try await UserService.editUserLibraries(newLibraries: myLibraries)
                    NotificationCenter.default.post(name: .detailChanged, object: nil)

                    await MainActor.run {
                        popToMyLibrary.value = true
                    }
                    
                } catch let error as NetworkError {
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func updateSearchState() {
        guard selectedRegion.value != nil else { return }
        guard selectedDetailRegion.value != nil else { return }
        
        searchEnableState.value = true
    }
}
