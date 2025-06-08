//
//  NetworkAPIClient.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 31/05/25.
//

import Foundation

class NetworkAPIClient {
    static let shared = NetworkAPIClient()
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        let urlString = "\(Constant.baseURl)movie/\(movieId)?api_key=\(Constant.Api_Key)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
            return movieDetails
        } catch {
            print("URL - \(urlString)")
            print(error)
            throw error
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
