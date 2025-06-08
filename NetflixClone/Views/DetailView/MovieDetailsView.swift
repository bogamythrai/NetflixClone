//
//  MovieDetailsView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 30/05/25.
//

import SwiftUI

struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    let mediaItem: MediaItem

    init(viewModel: ViewModel, mediaItem: MediaItem) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.mediaItem = mediaItem
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if viewModel.isLoading {
                        // Add progressView with white
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(.white)
                            .padding()
                            .alignmentGuide(.top) { _ in
                                return 0
                            }
                    } else {
                        if let errorMessage = viewModel.errorMessage {
                            ErrorMessageView(message: errorMessage)
                        }

                        headingView()
                        actionsView()
                        movieContentView()
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchMovieDetails(for: mediaItem.id)
        }
    }

    @ViewBuilder
    fileprivate func headingView() -> some View {
        AsyncImage(url: URL(string: Constant.backdropURL + (viewModel.movieDetails?.backdropPath ?? ""))) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.white)
                        .tint(.white)
                case .success(let image):
                    image
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .scaledToFill()
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    EmptyView()
            }
        }

        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.movieDetails?.title ?? mediaItem.title)
                .font(.largeTitle)
                .foregroundStyle(Color.white)
                .fontWeight(.bold)

            if let tagline = viewModel.movieDetails?.tagline, !tagline.isEmpty {
                Text(tagline)
                    .font(.headline)
                    .foregroundStyle(Color.gray)
            }
        }
    }

    @ViewBuilder
    fileprivate func movieContentView() -> some View {
        if let genres = viewModel.movieDetails?.genres {
            MovieDetailsGenresView(genres: genres)
        }

        Text(viewModel.movieDetails?.overview ?? "No description available.")
            .foregroundStyle(Color.white)
            .font(.body)

        HStack {
            Text("Release Date: \(viewModel.movieDetails?.releaseDate ?? "N/A")")
            Spacer()
            Text("Rating: \(viewModel.movieDetails?.voteAverage ?? 0)/10")
        }
        .font(.subheadline)
        .foregroundColor(.gray)

        if let runtime = viewModel.movieDetails?.runtime {
            Text("Runtime: \(runtime) minutes")
                .font(.subheadline)
                .foregroundColor(.gray)
        }

        if let productionCompanies = viewModel.movieDetails?.productionCompanies {
            VStack(alignment: .leading, spacing: 10) {
                Text("Production Companies:")
                    .font(.headline)
                    .foregroundColor(.white)
                ForEach(productionCompanies, id: \.id) { company in
                    Text(company.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    @ViewBuilder
    fileprivate func actionsView() -> some View {
        HStack(alignment: .center, spacing: 16) {
            Button(action: {}) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(5)
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                    Text("Watchlist")
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(5)
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(5)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMediaItem = MediaItem.sample
        let mockViewModel = MockMovieDetailsViewModel()
        return MovieDetailsView(viewModel: mockViewModel, mediaItem: sampleMediaItem)
    }
}
