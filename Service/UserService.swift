//
//  UserService.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func fetch(id: Int) async -> AnyPublisher<User, AppError>
}

// Define a class responsible for handling related services.

class UserService: UserServiceProtocol {
    
    private var user: User?
    private let repository: UserRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    required init() {
        self.repository = UserRepository()
    }
    
    func getAuthor() -> User? {
        user
    }

    func fetch(id: Int) async -> AnyPublisher<User, AppError> {
        await repository.fetch(id: id)
            .map { response in
                self.user = response
                return response
            }
            .eraseToAnyPublisher()
    }
    
}
