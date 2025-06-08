//
//  ContentView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 28/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - Views
struct ContentView: View {
    @State var isShowSplash: Bool = true

    var body: some View {
        ZStack(content: {
            Color.black.ignoresSafeArea()
            if isShowSplash {
                AnimatedImage(url: URL(string: "https://c.tenor.com/y9wRo5oAad4AAAAC/tenor.gif"))
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }else{
                NetflixHomeView()
            }
        })
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.isShowSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
