//
//  MovieList.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import Foundation

struct MovieList {
    let items: [MovieModel]
}

extension MovieList: Decodable {

    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
