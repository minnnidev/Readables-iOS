//
//  NetworkEnvironment.swift
//  BookTalk
//
//  Created by 김민 on 8/14/24.
//

import Foundation

struct NetworkEnvironment {

    static var baseURL: String {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("BASE_URL is missing in the Info.plist")
        }
        
        return baseURL.replacingOccurrences(of: " ", with: "")
    }
}
