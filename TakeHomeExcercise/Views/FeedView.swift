//
//  FeedView.swift
//  TakeHomeExcercise
//
//  Created by Rashida on 6/03/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.posts) { post in
                    PostView(post: post)
                        .id(post.id)
                }
            }
        }.scrollIndicators(.hidden)

    }
}

#Preview {
    FeedView()
}
