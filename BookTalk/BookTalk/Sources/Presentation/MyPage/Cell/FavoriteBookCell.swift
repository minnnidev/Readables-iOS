//
//  FavoriteBookCell.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class FavoriteBookCell: BaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue.withAlphaComponent(0.2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
