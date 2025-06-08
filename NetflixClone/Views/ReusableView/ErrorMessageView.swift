//
//  ErrorMessageView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 31/05/25.
//

import SwiftUI

struct ErrorMessageView: View {
    let message: String

    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.subheadline)
            .padding(.bottom, 10)
    }
}
