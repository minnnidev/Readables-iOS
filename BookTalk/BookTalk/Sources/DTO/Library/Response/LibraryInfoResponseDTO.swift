//
//  LibraryInfoResponseDTO.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

struct LibraryInfoResponseDTO: Decodable {
    let libCode: String?
    let libName: String?
    let address: String?
    let tel: String?
    let fax: String?
    let latitude: String?
    let longitude: String?
    let homepage: String?
    let closed: String?
    let operatingTime: String?
    let bookCount: String?
}

extension LibraryInfoResponseDTO {

    func toModel() -> LibraryInfo {
        return .init(
            code: libCode ?? "",
            name: libName ?? "도서관명 확인 불가",
            address: address ?? "주소 확인 불가",
            tel: tel ?? "번호 확인 불가"
        )
    }
}
