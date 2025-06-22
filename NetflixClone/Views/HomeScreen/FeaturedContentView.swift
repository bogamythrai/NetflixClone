//
//  FeaturedContentView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeaturedContentView: View {
    let featuredContent: MediaItem

    var body: some View {
        NavigationLink(destination:
                        MovieDetailsView(viewModel: MovieDetailsViewModel(), mediaItem: featuredContent)
        ) {
            ZStack(alignment: .bottom) {
                VStack {
                    WebImage(url: featuredContent.posterURL,
                             content: { image in
                        image
                    },
                             placeholder: placeholderView)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        ZStack(alignment: .bottom){
                            LinearGradient(colors: [.black.opacity(0.1),.clear,.black.opacity(0.1),.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: 1.0)
                        }
                    }
                }

                // Gradient overlay for better text visibility
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .center,
                    endPoint: .bottom
                )

                VStack(spacing: 15) {
                    Text(featuredContent.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    actionsView()
                }
                .padding(.bottom, 20)
            }
        }
    }

    @ViewBuilder
    fileprivate func actionsView() -> some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                HStack {
                    Image(systemName: "info.circle")
                    Text("More Info")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(5)
            }

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
        }
    }

    fileprivate func placeholderView() -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                Text(featuredContent.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
    }
}

// Create a Preview from NetflixData media data mock
#Preview {
    let item = MediaItem(id: 1,
                         title: "Lilo & Stitch",
                         overview: "The wildly funny and touching story of a lonely Hawaiian girl and the fugitive alien who helps to mend her broken family.",
                         posterPath: "/mKKqV23MQ0uakJS8OCE2TfV5jNS.jpg",
                         backdropPath: "/7Zx3wDG5bBtcfk8lcnCWDOLM4Y4.jpg",
                         releaseDate: "2025-05-17",
                         voteAverage: 7,
                         genreIds: [10751, 35, 878],
                         isTop10: true,
                         top10Rank: 2)
    FeaturedContentView(featuredContent: item)
}
