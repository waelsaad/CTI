//
//  MockUserService.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Combine
import Foundation

@testable import JSONSuite

class MockUserService: UserServiceProtocol {
    private let user: User

    init(user: User) {
        self.user = user
    }

    func fetch(id: Int) async -> AnyPublisher<User, AppError> {
        // Simulate a successful fetch by immediately returning the mock user
        Just(user)
            .setFailureType(to: AppError.self)
            .eraseToAnyPublisher()
    }
}
