//
//  CommentsEndPointTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class CommentsEndPointTests: XCTestCase {
    
    var api: API<CommentsEndpoint>!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        api = API<CommentsEndpoint>()
    }
    
    override func tearDown() {
        api = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_comments_endpoint_request_should_success() async {
        let expectation = expectation(description: "Request successful")
        
        let endpoint = CommentsEndpoint.comments(postId: 1)
        let publisher: AnyPublisher<[Comment], AppError> = await api.request(endpoint)
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            case .finished:
                expectation.fulfill()
            }
        } receiveValue: { _ in
            // We can assert or validate the received comment data here if needed.
        }
        
        cancellables.insert(cancellable)
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_comments_endpoint_request_should_return_empty_array() async {
        let expectation = expectation(description: "Request should return an empty array")
        
        let endpoint = CommentsEndpoint.comments(postId: 0)
        let publisher: AnyPublisher<[Comment], AppError> = await api.request(endpoint)
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Request should not fail. Error: \(error)")
            case .finished:
                // The request succeeded, but we expect an empty array.
                break
            }
        } receiveValue: { comments in
            XCTAssertTrue(comments.isEmpty, "Received non-empty array of comments.")
            expectation.fulfill()
        }
        
        cancellables.insert(cancellable)
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
}
