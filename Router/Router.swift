//
//  Router.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

/// The Router is an observable object which is used for decoupling views and view models for the purpose of app navigation.

class Router: ObservableObject {
    
    /// Used to programatically control our navigation stack
    @Published var path = NavigationPath()
    
    /// Observe list view model updates.
    @Bindable var postsList: PostsListView.PostsListViewModel
    
    // MARK: - Lifecycle
    
    /// The app home screen is the PostistView and has depdency on a view model.
    init(postsList: PostsListView.PostsListViewModel) {
        self.postsList = postsList
    }
    
    /// Builds the views to conform to the routes.
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .postsListView:
            PostsListView(viewModel: self.postsList)
        case .postDetailsView(let post):
            PostDetailsView(viewModel: .init(post: post))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    /// Using the navigation controller, we can navigate to the specified route without tightly coupling references to any specific views.
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    /// Used to go back to the previous screen
    
    func navigateBack() {
        path.removeLast()
    }
    
    /// Pop to the root screen in our hierarchy
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
}
