//
//  PostDetailsView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftData

// MARK: - PostDetailsView

struct PostDetailsView: View {

    var viewModel: PostDetailsViewModel
    
    @State var showEditDetails = false
    
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .failure(let error):
            errorView(error: error)
        case .success:
            successView
        }
    }
    
    @ViewBuilder
    private var successView: some View {
        ZStack {
            UI.gradient
                .edgesIgnoringSafeArea(.all)
            mainView
        }
        .background(editPostView)
        .navigationBarItems(trailing: editButton)
    }
    
    var mainView: some View {
        ScrollView {
            VStack(spacing: UI.Space.xSmall) {
                PostItemView(post: viewModel.post)
                if let user = viewModel.user {
                    AuthorView(author: user)
                }
                if !viewModel.comments.isEmpty {
                    CommentsView(comments: viewModel.comments)
                }
            }
            .padding(.bottom)
        }
    }
    
    // MARK: - Loading View
    
    /// The view to display when in the loading state.
    
    @ViewBuilder
    private var loadingView: some View {
        ZStack {
            UI.gradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: UI.Space.xSmall) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(UI.Dimensions.LoadingView.scaleEffect)
                Text(GlobalContent.loading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .accessibilityLabel(GlobalContent.loading)
            }
            .foregroundColor(.white)
            .offset(y: UI.Padding.LoadingView.yOffset)
        }
    }
    
    private var editButton: some View {
        Button {
            showEditDetails = true
        }
        .editStyle()
    }
    
    private var editPostView: some View {
        EmptyView()
            .fullScreenCover(isPresented: $showEditDetails) {
                EditPostView(viewModel: .init(post: viewModel.post))
                    .presentationDragIndicator(.visible)
            }
    }
    
    /// Generates the error view with the given error message.
    
    @ViewBuilder
    private func errorView(error: AppError) -> some View {
        ErrorView(error: error, retryAction: viewModel.retryAction)
    }
    
}

#Preview {
    PostDetailsView(
        viewModel: .init(post: Post(userId: 1, id: 1, title: "Sample Post", body: "This is a sample post.", isFavorite: false))
    )
    .previewLayout(.sizeThatFits)
    .padding()
}
