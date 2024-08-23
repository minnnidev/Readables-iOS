//
//  LayoutType.swift
//  BookTalk
//
//  Created by RAFA on 8/23/24.
//

import Foundation

enum LayoutType {
    case small
    case large
}

protocol BookDisplayable {
    var title: String { get }
    var author: String { get }
    var imageURL: String { get }
}
