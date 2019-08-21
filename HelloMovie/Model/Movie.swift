//
//  Movie.swift
//  HelloMovie
//
//  Created by Het Song on 21/08/2019.
//  Copyright © 2019 Het Song. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Float
}

struct MovieDetail: Codable {
    let poster_path: String?
    let title: String
    let tagline: String
    let release_date: String
    let vote_average: Float
    let runtime: Int
    let overview: String
}
