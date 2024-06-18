//
//  PostsEndpoint.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - This pattern allows us to easily add multiple methods to multiple endpoints.

// Define an enum to represent different posts methods.

enum PostsEndpoint {
    case all
    case post(Int)
}

// Extend PostsEndpoint to conform to EndpointType protocol.

extension PostsEndpoint: EndpointType {
    
    // Define the path for each endpoint case.
    
    var path: String {
        switch self {
        case .all:
            return "/posts" // Path for retrieving next posts.
        case .post(let id):
            return "/posts/\(id)"
        }
    }

    // Define the query parameters for each endpoint case.
    
    var query: [String: String] {
        switch self {
        case .all:
            return [:]
        case .post(let id):
            return ["id": "\(id)"]
        }
    }

    // Define the HTTP method for each endpoint case.
    
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get // Use GET method for retrieving posts.
        case .post(_):
            return .get // Use GET method for retrieving posts.
        }
    }

    // Define the HTTP headers for each endpoint case.
    
    var headers: HTTPHeaders? {
        switch self {
        case .all:
            return [:] // No specific headers needed for retrieving posts.
        case .post(_):
            return [:]
        }
    }
    
}
