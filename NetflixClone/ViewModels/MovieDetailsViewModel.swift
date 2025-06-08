//
//  MovieDetailsViewModel.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 31/05/25.
//

import Foundation

@MainActor
protocol MovieDetailsViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var movieDetails: MovieDetails? { get }
    func fetchMovieDetails(for id: Int)
}

@MainActor
class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    @Published var movieDetails: MovieDetails?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    func fetchMovieDetails(for movieId: Int) {
        isLoading = true
        Task {
            do {
                let details = try await NetworkAPIClient.shared.fetchMovieDetails(movieId: movieId)
                self.movieDetails = details
            } catch {
                self.errorMessage = "Failed to fetch movie details: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
