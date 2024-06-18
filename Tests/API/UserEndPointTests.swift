//
//  UserEndPointTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class UserEndPointTests: XCTestCase {
    
    var api: API<UserEndpoint>!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        api = API<UserEndpoint>()
    }
    
    override func tearDown() {
        api = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_user_details_request_should_success() async {
        
        let expectation = expectation(description: "Request successful")
        
        let endpoint = UserEndpoint.details(id: 1)
        let publisher: AnyPublisher<User, AppError> = await api.request(endpoint)
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        } receiveValue: { _ in
            // We can assert or validate the received user data here if needed.
        }
        
        cancellables.insert(cancellable)
        
        await fulfillment(of: [expectation], timeout: 5)
        
    }
    
    func test_user_details_request_should_fail_with_invalid_id() async {
        
        let expectation = expectation(description: "Request failed")
        
        // Providing an invalid endpoint to trigger a failure.
        
        let endpoint = UserEndpoint.details(id: -1) // Assuming this will result in a 404 or similar error.
        let publisher: AnyPublisher<User, AppError> = await api.request(endpoint)
        
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Request should have failed.")
            case .failure(let error):
                // In here we can also assert or validate the error type or details if needed.
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Request should not return a value.")
        }
        
        cancellables.insert(cancellable)
        
        await fulfillment(of: [expectation], timeout: 5)
        
    }
    
}
