//
//  PostItemView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct PostItemView: View {
    
    let post: Post
    
    // MARK: - Body
    
    /// The body of the containing the main view components.
    
    var body: some View {
        VStack(spacing: UI.Space.xxxSmall) {
            titleView
            bodyView
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity)
        .padding(.vertical, UI.Padding.PostItemView.vertical)
        .padding(.horizontal, UI.Padding.PostItemView.horizontal)
    }

    private var titleView: some View {
        Text(post.title)
            .bold()
            .fontWeight(.bold)
            .padding(.bottom, 6)
            .foregroundColor(.Text.Post.title)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.montserrat.bold(size: UI.FontSize.PostItemView.title))
    }

    private var bodyView: some View {
        Text(post.body)
            .font(.body)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .foregroundColor(.Text.Post.subTitle)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

}

// MARK: - Preview

#Preview {
    PostItemView(
        post: Post(userId: 1, id: 1, title: "Sample Post", body: "This is a sample post.", isFavorite: false)
    )
    .previewLayout(.sizeThatFits)
    .padding()
}
