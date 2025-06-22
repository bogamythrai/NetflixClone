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

    // Image properties
    @State private var scrollOffset: CGFloat = 0

    // Constants for image sizing
    private let defaultImageHeight: CGFloat = 400
    private let minImageHeight: CGFloat = 300
    private let maxStretchFactor: CGFloat = 1.3

    init(viewModel: ViewModel, mediaItem: MediaItem) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.mediaItem = mediaItem
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY

                        // Store the scroll offset
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: offset)
                            .frame(height: 0)

                        // Dynamic header image
                        dynamicHeaderImage(offset: offset)
                    }
                    .frame(height: calculateImageHeight())
                    
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

                            titleView()
                            actionsView()
                            movieContentView()
                        }
                    }
                    .padding()
                }
            }.scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.fetchMovieDetails(for: mediaItem.id)
        }
    }

    private func calculateImageHeight() -> CGFloat {
        // Calculate image height based on scroll position
        if scrollOffset > 0 {
            // Stretching when pulled down (with limit)
            return min(defaultImageHeight + scrollOffset, defaultImageHeight * maxStretchFactor)
        } else {
            // Shrinking when scrolling up (with minimum)
            return max(defaultImageHeight + scrollOffset, minImageHeight)
        }
    }

    @ViewBuilder
    private func dynamicHeaderImage(offset: CGFloat) -> some View {
        GeometryReader { imageGeometry in
            @State var isImageLoaded: Bool = false

            AsyncImage(url: URL(string: Constant.backdropURL + (viewModel.movieDetails?.backdropPath ?? ""))) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                            .tint(.white)
                            .frame(width: imageGeometry.size.width,
                                   height: imageGeometry.size.width,  alignment: .center)
                    case .success(let image):
                        image
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: imageGeometry.size.width,
                                   height: imageGeometry.size.width,
                                   alignment: .center)
                            .scaleEffect(x: 1 + max(0, offset / calculateImageHeight()),
                                         y: 1 + max(0, offset / calculateImageHeight()),
                                         anchor: .top)
                            .offset(y: offset > 0 ? -offset / 2 : 0) // Parallax effect when scrolling
                            .clipped()
                            .opacity(isImageLoaded ? 1: 0)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    isImageLoaded = true
                                }
                            }

                    case .failure:
                        Text("Image unavailable")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(width: imageGeometry.size.width, height:
                                    imageGeometry.size.width,
                                   alignment: .center)
                    @unknown default:
                        EmptyView()
                }
            }
        }
    }

    @ViewBuilder
    fileprivate func titleView() -> some View {
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

// Define a preference key to track scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMediaItem = MediaItem.sample
        let mockViewModel = MockMovieDetailsViewModel()
        return MovieDetailsView(viewModel: mockViewModel, mediaItem: sampleMediaItem)
    }
}
