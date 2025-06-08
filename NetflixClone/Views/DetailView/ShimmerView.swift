//
//  ShimmerView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 31/05/25.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                startPoint: .leading,
                endPoint: .trailing
            ))
            .animation(
                Animation.linear(duration: 1.5)
                    .repeatForever(autoreverses: false),
                value: UUID()
            )
    }
}
