//
//  FinishedBookCell.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class FinishedBookCell: BaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .accentOrange.withAlphaComponent(0.2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
