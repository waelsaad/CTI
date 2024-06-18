//
//  API.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import Combine

protocol APIProtocol {
    
    // Define a protocol with an associated type for the API endpoints.
    associatedtype Endpoint: EndpointType
    
    // Define a method to make a network request and return a publisher.
    func request<T: Decodable>(_ endpoint: Endpoint) async -> AnyPublisher<T, AppError>
    
}

class API<Endpoint: EndpointType>: APIProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async -> AnyPublisher<T, AppError> {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // Set timeout interval for requests (in seconds).
        configuration.timeoutIntervalForResource = 60 // Set timeout interval for resource fetching (in seconds).
        
        let sessionWithTimeout = URLSession(configuration: configuration)
        
        return sessionWithTimeout.dataTaskPublisher(for: endpoint.baseURL)
            .receive(on: DispatchQueue.main) // Receive the result on the main DispatchQueue.
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse, (200..<300)
                        .contains(httpResponse.statusCode)
                else {
                    throw AppError.networkError((response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> AppError in
                switch error {
                case is DecodingError:
                    if let decodingError = error as? DecodingError {
                        return .decodingError(decodingError)
                    } else {
                        // Handle unexpected error type here, if needed.
                        return .genericError(error)
                    }
                case let urlError as URLError where urlError.code == .notConnectedToInternet:
                    return .noInternet(urlError)
                default:
                    return .genericError(error)
                }
            }
            .eraseToAnyPublisher() // Erase the type to AnyPublisher to hide implementation details.
    }
    
}
