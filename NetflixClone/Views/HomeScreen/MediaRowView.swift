//
//  MediaRowView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI

struct MediaRowView: View {
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
                        NavigationLink(destination:
                                        MovieDetailsView(viewModel: MovieDetailsViewModel(), mediaItem: item)
                        ) {
                            MediaItemView(item: item)
                                .frame(width: 120, height: 180)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
    }
}
