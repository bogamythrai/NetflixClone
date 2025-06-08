//
//  MediaItem.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI
// MARK: - Models
struct MediaItem: Identifiable, Codable {
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
}

extension MediaItem {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: Constant.posterURL + posterPath)
    }
    
    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: Constant.backdropURL + backdropPath)
    }
}

enum MediaCategory: String, CaseIterable {
    case trending = "Trending Now"
    case top10 = "Top 10 in Your Country Today"
    case popular = "Popular on Netflix"
    case newReleases = "New Releases"
    case myList = "My List"
}
