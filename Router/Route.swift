//
//  Route.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

extension Router {
    
    /// Routes definition.
    
    enum Route: Hashable {
        
        /// Default route
        case postsListView
        
        /// To view an individual post details
        case postDetailsView(Post)
        
    }
    
}
