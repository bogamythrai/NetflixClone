//
//  NetflixCloneApp.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 28/05/25.
//

import SwiftUI

@main
struct NetflixCloneApp: App {

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
