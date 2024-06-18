//
//  PostsService.swift
//  JSONSuite
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine
import SwiftData

protocol PostsServiceProtocol {
    func fetchAll() async -> AnyPublisher<[Post], AppError>
}

// Define a class responsible for handling related services.

class PostsService: PostsServiceProtocol {
    
    private var posts: [Post] = []
    private let repository: PostsRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var container: ModelContainer?
    private let context: ModelContext?
    
    required init() {
        self.repository = PostsRepository()
        if let container = try? ModelContainer(for: Post.self) {
            self.container = container
            self.context = ModelContext(container)
        } else {
            self.container = nil
            self.context = nil
            print("Failed to create ModelContainer for Post")
        }
    }
    
    func fetchAll() -> [Post] {
        posts
    }
    
    func fetchPost(atIndex index: Int) -> Post? {
        (0..<posts.count).contains(index) ? posts[index] : nil
    }
    
    func count() -> Int {
        posts.count
    }

    func fetchAll() async -> AnyPublisher<[Post], AppError> {
        await repository.fetchAll()
            .map { response in
                self.posts = response
                return response
            }
            .eraseToAnyPublisher()
    }
    
}
