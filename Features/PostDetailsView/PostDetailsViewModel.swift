//
//  PostDetailsViewModel.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import Combine

extension PostDetailsView {
    
    @Observable final class PostDetailsViewModel: ObservableObject {
        
        // MARK: Enum properties
        
        enum State: Equatable {
            case loading
            case success
            case failure(AppError)
            
            static func == (lhs: State, rhs: State) -> Bool {
                switch (lhs, rhs) {
                case (.loading, .loading):
                    return true
                case (.success, .success):
                    return true
                case let (.failure(lhsError), .failure(rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
                }
            }
        }
        
        var post: Post
        var user: User?
        var comments: [Comment] = []
        var showErrorView = false
        
        var userService: UserServiceProtocol
        var commentsService: CommentsServiceProtocol
        var state: State = .loading
        private var cancellables: Set<AnyCancellable> = []
        
        init(
            post: Post,
            userService: UserServiceProtocol = UserService(),
            commentsService: CommentsServiceProtocol = CommentsService()
        ) {
            self.post = post
            self.userService = userService
            self.commentsService = commentsService
            
            Task(priority: .high) {
                await loadAuthor()
                await loadComments()
            }
        }
        
        func loadAuthor() async {
            await userService
                .fetch(id: post.userId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.showErrorView = true
                        let appError = self.handleError(error)
                        self.state = .failure(appError)
                        print("Error fetching post author:", appError.errorDescription)
                    case .finished:
                        print("Fetching auther completed successfully")
                    }
                }, receiveValue: { user in
                    self.showErrorView = false
                    self.user = user
                    self.state = .success

                })
                .store(in: &cancellables)
        }

        func loadComments() async {
            await commentsService
                .fetch(postId: post.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.showErrorView = true
                        let appError = self.handleError(error)
                        self.state = .failure(appError)
                        print("Error fetching post comments:", appError.errorDescription)
                    case .finished:
                        print("Fetching comments completed successfully")
                    }
                }, receiveValue: { comments in
                    self.showErrorView = false
                    self.comments = comments
                    self.state = .success

                })
                .store(in: &cancellables)
        }
        
        func retryAction() async {
            Task {
                var authorLoaded = false
                var commentsLoaded = false
                
                await loadAuthor()
                authorLoaded = true
                
                await loadComments()
                commentsLoaded = true

                // Set the state to .success only if both author and comments are loaded successfully
                if authorLoaded && commentsLoaded {
                    self.state = .success
                }
            }
        }
        
        deinit {
            cancellables.removeAll()
        }
        
    }
}

// MARK: Handles errors encountered during API request.

extension PostDetailsView.PostDetailsViewModel {
    
    private func handleError(_ error: Error) -> AppError {
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
