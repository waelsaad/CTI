//
//  EndpointType.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

enum EndpointError {
    case invalidURL
}

protocol EndpointType {
    
    // constructed base url
    var baseURL: URL { get }
    
    // path to endpoint - should start with '/'
    var path: String { get }
    
    // http method to use for request
    var method: HTTPMethod { get }
    
    // headers
    var headers: HTTPHeaders? { get }
    
    // query parameters
    var query: [String: String] { get }
    
}

extension EndpointType {
    
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = Endpoint.Configuration.kScheme
        components.host = Endpoint.Configuration.kServerURL
        // components.path = "\(Endpoint.Configuration.kVersion)" + path
        components.path = path
        
        if !query.isEmpty {
            components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard
            let url = components.url
        else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
}
