//
//  MovieDetailsView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 30/05/25.
//

import SwiftUI

struct MovieDetailsGenresView: View {
    let genres: [Genre]

    var body: some View {
        HStack {
            ForEach(genres, id: \.id) { genre in
                Text(genre.name)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundStyle(Color.white)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
}
