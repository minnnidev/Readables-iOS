//
//  MyPageStickyTabViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class MyPageStickyTabViewModel {
    
    // MARK: - Interactions
    
    struct Input {
        let tabSelected: (Int) -> Void
    }
    
    struct Output {
        let currentTabIndex: Observable<Int>
        let finishedBookCount: Observable<Int>
        let favoriteBookCount: Observable<Int>
    }
    
    // MARK: - Properties
    
    private let currentTabIndex: Observable<Int>
    private let finishedBookCount: Observable<Int>
    private let favoriteBookCount: Observable<Int>
    
    lazy var input: Input = { return bindInput() }()
    lazy var output: Output = { return transform() }()
    
    // MARK: - Initializer
    
    init(initialTabIndex: Int = 0, finishedBooks: Int = 0, favoriteBooks: Int = 0) {
        self.currentTabIndex = Observable(initialTabIndex)
        self.finishedBookCount = Observable(finishedBooks)
        self.favoriteBookCount = Observable(favoriteBooks)
    }
    
    // MARK: - Helpers
    
    func updateFinishedBookCount(_ count: Int) {
        finishedBookCount.value = count
    }
    
    func updateFavoriteBookCount(_ count: Int) {
        favoriteBookCount.value = count
    }
    
    private func selectTab(index: Int) {
        currentTabIndex.value = index
    }
    
    private func bindInput() -> Input {
        return Input(
            tabSelected: { [weak self] index in
                self?.selectTab(index: index)
            }
        )
    }
    
    private func transform() -> Output {
        return Output(
            currentTabIndex: currentTabIndex,
            finishedBookCount: finishedBookCount,
            favoriteBookCount: favoriteBookCount
        )
    }
}
