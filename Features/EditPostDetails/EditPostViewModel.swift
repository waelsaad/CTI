//
//  EditPostViewModel.swift
//  JSONSuite
//
//  Created by Wael Saad on 2/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

extension EditPostView {
    
    @Observable final class EditPostViewModel {
        
        var post: Post

        var title: String
        var body: String
        
        private let postsService: PostsServiceProtocol
        private let postsDataManager: PostsDataManagerProtocol
        
        init(
            post: Post, 
            postsService: PostsServiceProtocol = PostsService(),
            postsDataManager: PostsDataManagerProtocol = PostsDataManager()
        ) {
            self.post = post
            self.postsService = postsService
            self.postsDataManager = postsDataManager
            
            self.title = post.title
            self.body = post.body
        }
        
        func deletePost() {
            postsDataManager.deletePost(post)
        }
        
        // Reset post if the user clicks the close button after editing.
        
        func resetPost() {
            post.title = title
            post.body = body
        }
        
    }
    
}

extension EditPostView.EditPostViewModel: ObservableObject {
    
}
