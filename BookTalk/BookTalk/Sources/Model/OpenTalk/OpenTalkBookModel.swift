//
//  OpenTalkBookModel.swift
//  BookTalk
//
//  Created by 김민 on 8/20/24.
//

import Foundation

struct OpenTalkModel {
    let id: Int
    let bookName: String
    let bookImageURL: String
}

extension OpenTalkModel {

    static var stubOpenTalk1: OpenTalkModel {
        return .init(
            id: 0,
            bookName: "아몬드손원평 장편소설",
            bookImageURL: "http://image.aladin.co.kr/product/16839/4/cover/k492534773_1.jpg"
        )
    }

    static var stubOpenTalk2: OpenTalkModel {
        return .init(
            id: 1,
            bookName: "언어의 온도 :말과 글에는 나름의 따뜻함과 차가움이 있다",
            bookImageURL: "http://image.aladin.co.kr/product/14842/6/cover/k742532452_1.jpg"
        )
    }
}
