//
//  ReviewList.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import Foundation

struct ReviewList {
    let items: [ReviewModel]
}

extension ReviewList: Decodable {

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
