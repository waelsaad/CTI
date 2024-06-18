//
//  CommentsService.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

protocol CommentsServiceProtocol {
    func fetch(postId: Int) async -> AnyPublisher<[Comment], AppError>
}

// Define a class responsible for handling related services.

class CommentsService: CommentsServiceProtocol {
    
    private var comments: [Comment] = []
    private let repository: CommentsRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    required init() {
        self.repository = CommentsRepository()
    }
    
    func getAuthor() -> [Comment] {
        comments
    }

    func fetch(postId: Int) async -> AnyPublisher<[Comment], AppError> {
        await repository.fetch(postId: postId)
            .map { response in
                self.comments = response
                return response
            }
            .eraseToAnyPublisher()
    }
    
}
