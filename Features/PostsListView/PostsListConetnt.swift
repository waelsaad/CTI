//
//  PostsConetnt.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - PostsListView Content Configuration

extension PostsListView {
    
    // Define content-related constants.
    
    enum Content {
        static let title: LocalizedStringKey = "posts-list-title"
        static let alertTitle: LocalizedStringKey = "delete_alert_title"
        static let alertMessage: LocalizedStringKey = "delete_all_alert_message"
        static let alertButtonTitle: LocalizedStringKey = "delete_button_title"
        static let noPostsFound: LocalizedStringKey = "error_no_posts"
    }
    
}
