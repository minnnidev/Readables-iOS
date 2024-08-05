//
//  Observable.swift
//  BookTalk
//
//  Created by 김민 on 8/5/24.
//

import Foundation

final class Observable<T> {

    var value: T {
        didSet {
            self.listener?(value)
        }
    }

    var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
