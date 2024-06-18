//
//  PostsRepository.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

/// Define a protocol for a repository that fetches records.

protocol PostsRepositoryProtocol {
    func fetchAll() async -> AnyPublisher<[Post], AppError> // Define a method to fetch all posts.
}

/// Implement the repository protocol.

class PostsRepository: PostsRepositoryProtocol {
    
    private var api: API<PostsEndpoint> // Create an instance of API using the required endpoint.

    /// Initialize the repository with an optional API instance (defaults to a new instance).
    
    init(api: API<PostsEndpoint> = API<PostsEndpoint>()) {
        self.api = api
    }
    
    /// Implement the method to fetch all posts using the API.

    func fetchAll() async -> AnyPublisher<[Post], AppError> {
        await api.request(.all) // Make a request to fetch all posts.
    }

}
