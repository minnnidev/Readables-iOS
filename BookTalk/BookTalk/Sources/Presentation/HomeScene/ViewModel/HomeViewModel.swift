//
//  HomeViewModel.swift
//  BookTalk
//
//  Created by RAFA on 7/29/24.
//

import UIKit

final class HomeViewModel {
    
    private(set) var sections: [HomeSection] = [] {
        didSet {
            sectionsDidChange?(sections)
        }
    }
    
    var sectionsDidChange: (([HomeSection]) -> Void)?
    
    func fetchSections() {
        self.sections = MockData.sections
    }
}
