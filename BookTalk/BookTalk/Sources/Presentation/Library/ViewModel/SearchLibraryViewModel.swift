//
//  SearchLibraryViewModel.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

final class SearchLibraryViewModel {

    private(set) var selectedRegion: Observable<RegionType?> = Observable(nil)
    private(set) var selectedDetailRegion: Observable<DetailRegionType?> = Observable(nil)
    private(set) var searchEnableState = Observable(false)

    enum Action {
        case selectRegion(region: RegionType?)
        case selectDetailRegion(detailRegion: DetailRegionType?)
        case loadLibraryResult(region: RegionType?, detailRegion: DetailRegionType?)
    }

    func send(action: Action) {
        switch action {
        case let .selectRegion(region):
            guard let region = region else { return }
            selectedRegion.value = region
            updateSearchState()

        case let .selectDetailRegion(detailRegion):
            guard let detailRegion = detailRegion else { return }
            selectedDetailRegion.value = detailRegion
            updateSearchState()

        case let .loadLibraryResult(region, detailRegion):
            return

        }
    }

    private func updateSearchState() {
        guard let _ = selectedRegion.value else { return }
        guard let _ = selectedDetailRegion.value else { return }

        searchEnableState.value = true
    }
}
