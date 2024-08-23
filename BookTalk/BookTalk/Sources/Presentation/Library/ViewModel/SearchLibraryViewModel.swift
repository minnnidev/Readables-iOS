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

    enum Action {
        case selectRegion(region: RegionType)
        case selectDetailRegion(detailRegion: DetailRegionType)
    }

    func send(action: Action) {
        switch action {
        case let .selectRegion(region):
            selectedRegion.value = region

        case let .selectDetailRegion(detailRegion):
            selectedDetailRegion.value = detailRegion
        }
    }
}
