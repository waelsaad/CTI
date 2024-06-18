//
//  UserRepository.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

/// Define a protocol for a repository that fetches records.

protocol UserRepositoryProtocol {
    func fetch(id: Int) async -> AnyPublisher<User, AppError> // Define a method to fetch all posts.
}

/// Implement the repository protocol.

class UserRepository: UserRepositoryProtocol {
    
    private var api: API<UserEndpoint> // Create an instance of API using the required endpoint.

    /// Initialize the repository with an optional API instance (defaults to a new instance).
    
    init(api: API<UserEndpoint> = API<UserEndpoint>()) {
        self.api = api
    }
    
    /// Implement the method to fetch all posts using the API.

    func fetch(id: Int) async -> AnyPublisher<User, AppError> {
        await api.request(.details(id: id)) // Make a request to fetch all posts.
    }

}
