//
//  Top10RowView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI

struct Top10RowView: View {
    let title: String
    let items: [MediaItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(items) { item in
                        if let rank = item.top10Rank {
                            NavigationLink(destination:
                                            MovieDetailsView(viewModel: MovieDetailsViewModel(), mediaItem: item)
                            ) {
                                ZStack(alignment: .bottomLeading) {
                                    HStack {
                                        Spacer()
                                        MediaItemView(item: item)
                                            .frame(width: 120, height: 180)
                                    }

                                    Text("\(rank)")
                                        .font(.system(size: 80, weight: .bold))
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.white, .white, .black.opacity(0.8)],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .shadow(color: .black.opacity(0.6), radius: 2, x: 1, y: 1)
                                        .offset(x: 10, y: 20)
                                }
                                .frame(width: 150)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
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
    Top10RowView(title: "", items: [item])
}
