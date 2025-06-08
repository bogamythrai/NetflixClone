//
//  NetflixHomeView.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import SwiftUI

struct NetflixHomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                GeometryReader { _ in
                    ScrollView {
                        VStack {
                            headerView()
                                .padding(.all,20)
                            listView()
                        }
                        .padding(.bottom,30)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onDisappear{UIScrollView.appearance().bounces = true}
            .toolbar {
                navigationBarContent()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private func headerView() -> some View {
        ZStack{
            VStack {
                if let featuredContent = viewModel.featuredContent {
                    FeaturedContentView(featuredContent: featuredContent)
//                        .frame(width: size.width, height: 450)
                }
            }
        }
    }

    @ViewBuilder
    private func listView() -> some View {
        ForEach(Array(viewModel.categorizedMedia.keys), id: \.self) { category in
            if category == MediaCategory.top10.rawValue {
                Top10RowView(
                    title: category,
                    items: viewModel.categorizedMedia[category] ?? []
                )
            } else {
                MediaRowView(
                    title: category,
                    items: viewModel.categorizedMedia[category] ?? []
                )
            }
        }
    }

    @ToolbarContentBuilder
    private func navigationBarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Image("netflix")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 32)
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                }
                Button(action: {}) {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    NetflixHomeView(viewModel: HomeViewModel())
}
