//
//  CommentsEndpoint.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - This pattern allows us to easily add multiple methods to multiple endpoints.

// Define an enum to represent different posts methods.

enum CommentsEndpoint {
    case comments(postId: Int)
}

// Extend PostsEndpoint to conform to EndpointType protocol.

extension CommentsEndpoint: EndpointType {
    
    // Define the path for each endpoint case.
    
    var path: String {
        switch self {
        case .comments(_):
            return "/comments"
        }
    }

    // Define the query parameters for each endpoint case.
    
    var query: [String: String] {
        switch self {
        case .comments(let id):
            return ["postId": "\(id)"]
        }
    }

    // Define the HTTP method for each endpoint case.
    
    var method: HTTPMethod {
        switch self {
        case .comments(_):
            return .get // Use GET method for retrieving posts.
        }
    }

    // Define the HTTP headers for each endpoint case.
    
    var headers: HTTPHeaders? {
        switch self {
        case .comments(_):
            return [:]
        }
    }
    
}
