//
//  MockMovieDetailsViewModel.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 31/05/25.
//

import SwiftUI

class MockMovieDetailsViewModel: MovieDetailsViewModelProtocol {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var movieDetails: MovieDetails? = MovieDetails(
        adult: false,
        backdropPath: "/7Zx3wDG5bBtcfk8lcnCWDOLM4Y4.jpg",
        belongsToCollection: nil,
        budget: 100000000,
        genres: [
            Genre(id: 10751, name: "Family"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 878, name: "Science Fiction")
        ],
        homepage: "https://movies.disney.com/lilo-and-stitch-2025",
        id: 552524,
        imdbID: "tt11655566",
        originCountry: ["US"],
        originalLanguage: "en",
        originalTitle: "Lilo & Stitch",
        overview: "The wildly funny and touching story of a lonely Hawaiian girl and the fugitive alien who helps to mend her broken family.",
        popularity: 733.0556,
        posterPath: "/Y6pjszkKQUZ5uBbiGg7KWiCksJ.jpg",
        productionCompanies: [
            ProductionCompany(id: 2, logoPath: "/wdrCwmRnLFJhEoH8GSfymY85KHT.png", name: "Walt Disney Pictures", originCountry: "US"),
            ProductionCompany(id: 118854, logoPath: "/g9LPNlQFoDcHjfnvrEqFmeIaDrZ.png", name: "Rideback", originCountry: "US")
        ],
        releaseDate: "2025-05-17",
        revenue: 421400000,
        runtime: 108,
        status: "Released",
        tagline: "Hold on to your coconuts.",
        title: "Lilo & Stitch",
        video: false,
        voteAverage: 7.138,
        voteCount: 325
    )

    func fetchMovieDetails(for id: Int) {
        // Mock implementation
    }
}
