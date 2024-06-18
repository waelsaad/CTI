//
//  MockCommentsService.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Combine
import Foundation

@testable import JSONSuite

class MockCommentsService: CommentsServiceProtocol {
    private let comments: [Comment]

    init(comments: [Comment]) {
        self.comments = comments
    }

    func fetch(postId: Int) async -> AnyPublisher<[Comment], AppError> {
        // Simulate a successful fetch by immediately returning the mock comments
        Just(comments)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
}
