//
//  ProfileInfoViewModel.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

protocol ProfileInfoViewModelDelegate: AnyObject {
    
    func didTapAddFinishedBookButton()
    
    func didTapEditLibraryButton()
}

final class ProfileInfoViewModel {
    
    // MARK: - Interactions
    
    struct Input {
        let addFinishedBookButtonTap: () -> Void
        let editLibraryButtonTap: () -> Void
        let textFieldTexts: Observable<[String]>
    }
    
    struct Output {
        let profileImage: Observable<UIImage?>
        let name: Observable<String>
        let genderAgeText: Observable<String>
        let addedTexts: Observable<[String]>
    }
    
    // MARK: - Properties
    
    weak var delegate: ProfileInfoViewModelDelegate?
    
    private let profileImage = Observable<UIImage?>(nil)
    private let name = Observable<String>("애벌레")
    private let genderAgeText = Observable<String>("남 • 20")
    private let addedTexts: Observable<[String]> = Observable([])
    
    lazy var input: Input = { return bindInput() }()
    lazy var output: Output = { return transform() }()
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Helpers
    
    func updateAddedTexts(_ texts: [String]) {
        addedTexts.value = texts
    }
    
    private func bindInput() -> Input {
        return Input(
            addFinishedBookButtonTap: {
                self.delegate?.didTapAddFinishedBookButton()
            },
            editLibraryButtonTap: {
                self.delegate?.didTapEditLibraryButton()
            },
            textFieldTexts: addedTexts
        )
    }
    
    private func transform() -> Output {
        return Output(
            profileImage: profileImage,
            name: name,
            genderAgeText: genderAgeText,
            addedTexts: addedTexts
        )
    }
}
