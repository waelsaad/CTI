//
//  PostsListView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftData

// MARK: - PostsListView

/// This view displays a list of all posts.

struct PostsListView: View {
    
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) private var modelContext
    
    @State var showDeleteAlert = false
    @State private var isRefreshing = false
    
    var viewModel: PostsListViewModel
    
    // @Bindable var errorhandling: AlertError
    
    /// The main view that dynamically displays loading, error, or success views based on the state of the view model.
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .failure(let error):
            errorView(error: error)
        case .success(let posts):
            successView(posts: posts)
        }
    }
    
    // MARK: - Main View
    
    /// The content of the list based on the view model state.
    
    private func successView(posts: [Post]) -> some View {
        ScrollView {
            LazyVStack(spacing: 1) {
                listView(posts: posts)
                // ForEach(posts, content: PostItem.init)
            }
        }
        .padding(.top)
        .refreshable {
            isRefreshing = true
            await viewModel.fetchAll()
            isRefreshing = false
        }
        .navigationTitle(Content.title)
        .accessibilityLabel(Content.title)
        .navigationBarTitleDisplayMode(.large)
        .accessibilityElement(children: .contain)
        .navigationBarItems(trailing: deleteAllButton)
    }
    
    private func listView(posts: [Post]) -> some View {
        VStack(spacing: 3) {
            let posts = viewModel.posts
            if posts.isEmpty {
                noItemsView
            }
            ForEach(viewModel.posts.indices, id: \.self) { index in
                let post = posts[index]
                NavRow(
                    title: post.title,
                    subTitle: post.formattedDate,
                    position: Position.calculate(index: index, totalItems: posts.count)
                )
                .onTapGesture {
                    router.navigateTo(.postDetailsView(post))
                }
                .contextMenu {
                    Button {
                        viewModel.deletePost(at: index)
                    } label: {
                        Text(GlobalContent.delete)
                        Image(systemImage: .trash)
                    }
                }
            }
        }
        .onAppear {
            viewModel.LoadFromLocalStorage()
        }
    }
    
    // MARK: - Loading View
    
    /// The view to display when in the loading state.
    
    @ViewBuilder
    private var loadingView: some View {
        ZStack {
            UI.gradient
                .edgesIgnoringSafeArea(.all)
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
        }
    }
    
    // MARK: - No Items View
    
    /// The view to display when there are no items.
    
    private var noItemsView: some View {
        VStack(alignment: .center) {
            Text(Content.noPostsFound)
                .font(.headline)
                .foregroundColor(.Text.Post.noPostsFound)
        }
        .align(.centerY)
        .padding()
        .padding(.top, UI.Padding.NoItemsView.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var deleteAllButton: some View {
        Button {
            showDeleteAlert = true
        } label: {
            Image(systemName: SystemImage.trash.rawValue)
                .foregroundColor(viewModel.posts.isEmpty ? .gray : .Button.delete)
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text(Content.alertTitle),
                message: Text(Content.alertMessage),
                primaryButton: .destructive(Text(Content.alertButtonTitle)) {
                    showDeleteAlert = false
                    viewModel.deleteAll()
                },
                secondaryButton: .cancel()
            )
        }
        .disabled(viewModel.posts.isEmpty)
    }
    
    /// Generates the error view with the given error message.
    
    private func errorView(error: AppError) -> some View {
        ErrorView(error: error, retryAction: viewModel.retry)
    }
    
}

// MARK: - Preview

#Preview {
    PostsListView(viewModel: .init())
}
