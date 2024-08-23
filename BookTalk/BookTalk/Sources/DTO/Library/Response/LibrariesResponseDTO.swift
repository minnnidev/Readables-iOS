//
//  LibrariesResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct UserLibraryResponseDTO: Decodable {
    let libraries: [LibraryResponseDTO]
}

struct LibraryResponseDTO: Decodable {
    let code: String
    let name: String
}

extension LibraryResponseDTO {

    func toModel() -> LibraryInfo {
        return .init(
            code: code,
            name: name,
            address: nil,
            tel: nil
        )
    }
}
