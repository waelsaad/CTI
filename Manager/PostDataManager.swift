//
//  PostDataManager.swift
//  JSONSuite
//
//  Created by Wael Saad on 2/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import SwiftData

protocol PostsDataManagerProtocol {
    func deleteAll()
    func loadAll() -> [Post]
    func insertPost(_ post: Post)
    func deletePost(_ post: Post)
    func savePosts(posts: [Post])
}

// Define a class responsible for handling stored data. (First Exposure to SwiftData)

class PostsDataManager: PostsDataManagerProtocol {
    
    private let context: ModelContext?
    private var container: ModelContainer?
    
    required init() {
        if let container = try? ModelContainer(for: Post.self) {
            self.container = container
            self.context = ModelContext(container)
        } else {
            self.container = nil
            self.context = nil
            print("Failed to create ModelContainer for Post")
        }
    }
    
    func insertPost(_ post: Post) {
        context?.insert(post)
        try? context?.save()
    }

    func deletePost(_ post: Post) {
        if let context = post.modelContext {
          context.delete(post)
        }
    }

    func savePosts(posts: [Post]) {
        if !loadAll().isEmpty { deleteAll() }
        posts.forEach { context?.insert($0) }
    }
    
    func loadAll() -> [Post] {
        let fetchDescriptor = FetchDescriptor<Post>(sortBy: [SortDescriptor(\.title)])
        do {
            return try context?.fetch(fetchDescriptor) ?? []
        } catch {
            print("Error fetching posts: \(error)")
            return []
        }
    }
    
    func deleteAll() {
        guard let context = context else {
            print("Context is nil, cannot delete posts.")
            return
        }
        
        do {
            let fetchDescriptor = FetchDescriptor<Post>()
            let posts = try context.fetch(fetchDescriptor)
            posts.forEach { context.delete($0) }
            try? context.save()
        } catch {
            print("Error deleting posts: \(error)")
        }
    }
    
}
