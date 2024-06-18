//
//  PostsListViewModel.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import Combine

extension PostsListView {
    
    @Observable final class PostsListViewModel {
        
        // MARK: Enum properties
        
        enum State: Equatable {
            case loading
            case success([Post])
            case failure(AppError)
            
            static func == (lhs: State, rhs: State) -> Bool {
                switch (lhs, rhs) {
                case (.loading, .loading):
                    return true
                case let (.success(lhsSummaries), .success(rhsSummaries)):
                    return lhsSummaries == rhsSummaries
                case let (.failure(lhsError), .failure(rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
                }
            }
        }
        
        // MARK: Exposed properties
        
        var posts: [Post] = []

        var showErrorView = false
        
        // MARK: Private properties

        var state: State = .loading
        private var cancellables: Set<AnyCancellable> = []
        
        private let postsService: PostsServiceProtocol
        private let postsDataManager: PostsDataManagerProtocol
        
        // MARK: Init
        
        init(
            postsService: PostsServiceProtocol = PostsService(),
            postsDataManager: PostsDataManagerProtocol = PostsDataManager()
        ) {
            self.postsService = postsService
            self.postsDataManager = postsDataManager
            loadPostsIfNeeded()
        }

        func loadPostsIfNeeded() {
            switch self.postsDataManager.loadAll().isEmpty {
            case true:
                fetchFromAPI()
            case false:
                LoadFromLocalStorage()
            }
        }
        
        func fetchFromAPI() {
            Task(priority: .medium) {
                await fetchAll()
            }
        }
        
        func LoadFromLocalStorage() {
            self.posts = self.postsDataManager.loadAll()
            self.state = .success(self.posts)
        }
        
        // An Approach using MainActor
        
        @MainActor
        func fetchAll() async {
            await postsService.fetchAll()
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        self.showErrorView = true
                        let appError = self.handleError(error)
                        self.state = .failure(appError)
                        print("Error fetching posts:", appError.errorDescription)
                    case .finished:
                        print("Fetching posts completed successfully")
                    }
                } receiveValue: { posts in
                    self.showErrorView = false
                    self.posts = posts.sortedByTitle
                    // self.posts = posts.topThreeSortedByTitle
                    self.state = .success(self.posts)
                    self.postsDataManager.savePosts(posts: self.posts)
                }
                .store(in: &cancellables) // Store the subscription to avoid memory leaks
        }
        
        // An alternative approach known approach. Both approaches work just fine.
        
        func fetchAllAnotherApproachNotUsed() async {
            await postsService.fetchAll()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.showErrorView = true
                        let appError = self.handleError(error)
                        self.state = .failure(appError)
                        print("Error fetching posts:", appError.errorDescription)
                    case .finished:
                        print("Fetching posts completed successfully")
                    }
                }, receiveValue: { posts in
                    self.showErrorView = false
                    self.posts = posts.sortedByTitle
                    self.state = .success(self.posts)
                    self.postsDataManager.savePosts(posts: self.posts)
                })
                .store(in: &cancellables) // Store the subscription to avoid memory leaks
        }
        
        func deletePost(at index: Int) {
            guard index >= 0 && index < posts.count else { return }
            postsDataManager.deletePost(posts[index])
            posts.remove(at: index)
        }
        
        func deleteAll() {
            self.posts = []
            self.postsDataManager.deleteAll()
        }
        
        // Retry action closure to be triggered from ErrorView
        
        func retry() async {
            Task {
                await fetchAll()
            }
        }
        
        deinit {
            cancellables.removeAll()
        }
        
    }
    
}

// MARK: Handles errors encountered during API request.

extension PostsListView.PostsListViewModel {
    
    func handleError(_ error: Error) -> AppError {
        switch error {
        case let appError as AppError:
            return appError
        case let urlError as URLError:
            return .noInternet(urlError)
        case let decodingError as DecodingError:
            return .decodingError(decodingError)
        default:
            return .genericError(error)
        }
    }
    
}
