//
//  MovieModel.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import Foundation

struct MovieModel {
    let id: Int
    let type: String?
    let title: String?
    let name: String?
    let overview: String
    let poster: String?
    let voteAverage: Float
    let releaseDate: String?
}

extension MovieModel: Hashable {
    static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case type = "media_type"
        case title
        case name
        case overview
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
