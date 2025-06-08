//
//  ImageModifier.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI
// MARK: - Image Modifier
extension Image {
    func applyImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(5)
    }
}
