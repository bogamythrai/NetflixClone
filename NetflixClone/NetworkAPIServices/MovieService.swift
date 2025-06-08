//
//  MovieService.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import Foundation

// TMDB API Response Models
struct TMDBResponse: Codable {
    let page: Int
    let results: [MovieResult]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieResult: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let genreIds: [Int]
    let isTop10: Bool
    let top10Rank: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case isTop10
        case top10Rank
    }
}

struct GenreResults: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
