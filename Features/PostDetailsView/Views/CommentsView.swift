//
//  PostItemView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct CommentsView: View {
 
    var comments: [Comment]
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            sectionView
                .background(Color.clear)
        }
    }
    
    private var header: some View {
        HStack(spacing: UI.Space.xxxSmall) {
            Text(Content.header)
                .textCase(nil)
                .foregroundColor(.Text.Comments.header)
                .font(.montserrat.bold(size: UI.FontSize.sectionHeader))
            Text("(\(comments.count))")
                .foregroundColor(.Text.Comments.count)
                .font(.montserrat.light(size: UI.FontSize.commentsCount))
        }
        .padding(.horizontal)
    }
    
    private var sectionView: some View {
        VStack(spacing: 3) {
            ForEach(comments.indices, id: \.self) { index in
                commentView(for: comments[index])
            }
        }
    }
    
    @ViewBuilder
    private func commentView(for comment: Comment) -> some View {
          VStack(spacing: UI.Space.xxxSmall) {
              commentTitleView(title: comment.name)
              commentBodyView(bodyText: comment.body)
          }
          .padding()
          Color.navLinkDivider.frame(height: 2).opacity(0.3)
      }
      
      private func commentTitleView(title: String) -> some View {
          Text(title)
              .bold()
              .fontWeight(.bold)
              .padding(.bottom, 6)
              .foregroundColor(.Text.Comments.title)
              .fixedSize(horizontal: false, vertical: true)
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.montserrat.bold(size: UI.FontSize.CommentView.title))
      }
      
      private func commentBodyView(bodyText: String) -> some View {
          Text(bodyText)
              .font(.body)
              .lineLimit(nil)
              .multilineTextAlignment(.leading)
              .foregroundColor(.Text.Comments.subTitle)
              .fixedSize(horizontal: false, vertical: true)
              .frame(maxWidth: .infinity, alignment: .leading)
      }

}

extension CommentsView {
    
    // Define content-related constants.
    
    enum Content {
        static let header: LocalizedStringKey = "comments_header"
    }
    
}

#Preview {
    let sampleComment = Comment(postId: 1, id: 1, name: "John Doe", email: "johndoe@example.com", body: "This is a sample comment.")
    return CommentsView(comments: [sampleComment])
}
