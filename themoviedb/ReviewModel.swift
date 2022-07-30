//
//  ReviewModel.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import Foundation

struct ReviewModel {
    let id: String
    let theAuthorDetail: AuthorDetails
    let theReview: String
    let theReviewDate: String
}

extension ReviewModel: Hashable {
    static func == (lhs: ReviewModel, rhs: ReviewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ReviewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case theAuthorDetail = "author_details"
        case theReview = "content"
        case theReviewDate = "created_at"
    }
}

struct AuthorDetails {
    let name: String
    let username: String?
}

extension AuthorDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case username
    }
}
