//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import Foundation
import SwiftUI

// MARK: - ViewModel
class HomeViewModel: ObservableObject {
    @Published var featuredContent: MediaItem?
    @Published var categorizedMedia: [String: [MediaItem]] = [:]

    init() {
        loadMockData()
    }

    func loadMockData() {
        guard let netflixData = try? Bundle.data(for: "NetflixData", type: "json"),
              let genresData = try? Bundle.data(for: "Genres", type: "json"),
              let tmdbResponse = netflixData.decode(as: TMDBResponse.self),
              let genresResponse = genresData.decode(as: GenreResults.self)
        else {
            print("Failed to load mock data")
            return
        }

        let genreMap = genresResponse.genres.reduce(into: [Int: String]()) { (dict, genre) in
            dict[genre.id] = genre.name
        }

        // Set featuredContent to the first movie in the results
        if let firstMovie = tmdbResponse.results.first {
            self.featuredContent = MediaItem(
                id: firstMovie.id,
                title: firstMovie.title,
                overview: firstMovie.overview,
                posterPath: firstMovie.posterPath,
                backdropPath: firstMovie.backdropPath,
                releaseDate: firstMovie.releaseDate,
                voteAverage: firstMovie.voteAverage,
                genreIds: firstMovie.genreIds,
                isTop10: firstMovie.isTop10,
                top10Rank: firstMovie.top10Rank
            )
        }

        // Organize media items by category
        // in this tmdbResponse.results filter the movies where isTop10 is true and sort them by top10Rank
        // and add them under MovieCategory.top10.rawValue
        let top10Movies = tmdbResponse.results.filter { $0.isTop10 && $0.top10Rank != nil }
            .sorted { $0.top10Rank ?? Int.max < $1.top10Rank ?? Int.max }
            .map { movie in
                MediaItem(
                    id: movie.id,
                    title: movie.title,
                    overview: movie.overview,
                    posterPath: movie.posterPath,
                    backdropPath: movie.backdropPath,
                    releaseDate: movie.releaseDate,
                    voteAverage: movie.voteAverage,
                    genreIds: movie.genreIds,
                    isTop10: movie.isTop10,
                    top10Rank: movie.top10Rank
                )
            }
        categorizedMedia[MediaCategory.top10.rawValue] = top10Movies

        for (genreId, genreName) in genreMap {
            let categoryItems = tmdbResponse.results.filter { movie in
                movie.genreIds.contains(genreId)
            }.map { movie in
                MediaItem(
                    id: movie.id,
                    title: movie.title,
                    overview: movie.overview,
                    posterPath: movie.posterPath,
                    backdropPath: movie.backdropPath,
                    releaseDate: movie.releaseDate,
                    voteAverage: movie.voteAverage,
                    genreIds: movie.genreIds,
                    isTop10: movie.isTop10,
                    top10Rank: movie.top10Rank
                )
            }
            if categoryItems.isEmpty { continue }
            categorizedMedia[genreName] = categoryItems
        }
    }
}
