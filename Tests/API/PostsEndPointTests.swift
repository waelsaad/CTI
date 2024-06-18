//
//  PostsEndPointTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class PostsEndPointTests: XCTestCase {
    
    var api: API<PostsEndpoint>!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        api = API<PostsEndpoint>()
    }
    
    override func tearDown() {
        api = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_posts_endpoint_request_should_success() async {
        
        let expectation = expectation(description: "Request successful")
        
        let endpoint = PostsEndpoint.all
        let publisher: AnyPublisher<[Post], AppError> = await api.request(endpoint)
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        } receiveValue: { _ in
            // We can assert or validate the received post data here if needed.
        }
        
        cancellables.insert(cancellable)
        
        await fulfillment(of: [expectation], timeout: 5)
        
    }
    
}
