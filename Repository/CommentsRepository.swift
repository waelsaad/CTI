//
//  CommentsRepository.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

/// Define a protocol for a repository that fetches records.

protocol CommentsRepositoryProtocol {
    func fetch(postId: Int) async -> AnyPublisher<[Comment], AppError> // Define a method to fetch all posts.
}

/// Implement the repository protocol.

class CommentsRepository: CommentsRepositoryProtocol {
    
    private var api: API<CommentsEndpoint> // Create an instance of API using the required endpoint.

    /// Initialize the repository with an optional API instance (defaults to a new instance).
    
    init(api: API<CommentsEndpoint> = API<CommentsEndpoint>()) {
        self.api = api
    }
    
    /// Implement the method to fetch all posts using the API.

    func fetch(postId: Int) async -> AnyPublisher<[Comment], AppError> {
        await api.request(.comments(postId: postId)) // Make a request to fetch all posts.
    }

}
