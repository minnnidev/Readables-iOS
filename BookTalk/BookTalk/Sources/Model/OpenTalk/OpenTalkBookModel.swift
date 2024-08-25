//
//  OpenTalkBookModel.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct OpenTalkBookModel {
    let id: Int
    let isbn: String
    let bookName: String
    let bookImageURL: String
}

extension OpenTalkBookModel {

    static var stubOpenTalk1: OpenTalkBookModel {
        return .init(
            id: 5,
            isbn: "9788936434267",
            bookName: "아몬드손원평 장편소설",
            bookImageURL: "http://image.aladin.co.kr/product/16839/4/cover/k492534773_1.jpg"
        )
    }

    static var stubOpenTalk2: OpenTalkBookModel {
        return .init(
            id: 10,
            isbn: "9791195522125",
            bookName: "언어의 온도 :말과 글에는 나름의 따뜻함과 차가움이 있다",
            bookImageURL: "http://image.aladin.co.kr/product/14842/6/cover/k742532452_1.jpg"
        )
    }
}
