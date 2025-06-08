//
//  MediaItemView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MediaItemView: View {
    let item: MediaItem

    var body: some View {
        ZStack {
            WebImage(url: item.posterURL,
                     content: { image in
                        image
                    },
                     placeholder: placeholderView)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .background(RoundedRectangle(cornerRadius: 10))
        }
    }

    fileprivate func placeholderView() -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .overlay(
                Text(item.title)
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(4)
            )
    }
}
