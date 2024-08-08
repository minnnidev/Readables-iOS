//
//  HomeViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Properties
    
    private let sectionsRelay = Observable<[HomeSection]>([])
    var sections: [HomeSection] { return sectionsRelay.value }
    var sectionsObservable: Observable<[HomeSection]> { return sectionsRelay }
    
    // MARK: - Helpers
    
    func fetchSections() { sectionsRelay.value = HomeMockData.sections }
}
