//
//  MockPostsService.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Combine
import Foundation

@testable import JSONSuite

class MockPostsService: PostsServiceProtocol {
    private let posts: [Post]

    init(posts: [Post]) {
        self.posts = posts
    }

    func fetchAll() async -> AnyPublisher<[Post], AppError> {
        // Simulate a successful fetch by immediately returning the mock posts
        Just(posts)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
}
