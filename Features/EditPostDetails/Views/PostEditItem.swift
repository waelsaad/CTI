//
//  PostEditItem.swift
//  JSONSuite
//
//  Created by Wael Saad on 2/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftData

struct PostEditItem: View {
    
    @Binding var post: Post
    
    // MARK: - Body
    
    /// The body of the containing the main view components.
    
    var body: some View {
        VStack(spacing: UI.Space.small) {
            titleView
            bodyView
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity)
        .padding(.vertical, UI.Padding.PostItemView.vertical)
        .padding(.horizontal, UI.Padding.PostItemView.horizontal)
    }

    private var titleView: some View {
        VStack(spacing: UI.Space.xxSmall) {
            Text("Title")
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.montserrat.bold(size: UI.FontSize.PostItemView.title))
            
            TextEditor(text: $post.title)
                .styleEditor(
                    minHeight: UI.FormField.Title.minHeight,
                    maxHeight: UI.FormField.Title.maxHeight
                )
        }
    }

    private var bodyView: some View {
        VStack(spacing: UI.Space.xxSmall) {
            Text("Body")
                .bold()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.montserrat.bold(size: UI.FontSize.PostItemView.title))
            
            TextEditor(text: $post.body)
                .styleEditor(
                    minHeight: UI.FormField.Body.minHeight,
                    maxHeight: UI.FormField.Body.maxHeight
                )
        }
    }

}

// MARK: - Preview

#Preview {
    let post = Post(userId: 1, id: 1, title: "Sample Post", body: "This is a sample post.", isFavorite: false)
    return PostEditItem(post: .constant(post))
    .previewLayout(.sizeThatFits)
    .padding()
}
