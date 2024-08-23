//
//  EditLibraryRequestDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct EditLibraryRequestDTO: Encodable {
    let libraries: [LibraryRequestDTO]
}

struct LibraryRequestDTO: Encodable {
    let code: String
    let name: String
}

