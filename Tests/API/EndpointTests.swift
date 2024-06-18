//
//  EndpointTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
@testable import JSONSuite

final class EndpointTests: XCTestCase {
    
    func test_comments_endpoint_should_have_correct_url_and_method() {
        let endpoint = CommentsEndpoint.comments(postId: 1)
        
        XCTAssertEqual(endpoint.baseURL.absoluteString, "https://jsonplaceholder.typicode.com/comments?postId=1")
        XCTAssertEqual(endpoint.path, "/comments")
        XCTAssertEqual(endpoint.query, ["postId": "1"])
        XCTAssertEqual(endpoint.method, .get)
    }

    func test_posts_endpoint_should_have_correct_url_and_method() {
        let endpoint = PostsEndpoint.all
        XCTAssertEqual(endpoint.baseURL.absoluteString, "https://jsonplaceholder.typicode.com/posts")
        XCTAssertEqual(endpoint.path, "/posts")
        XCTAssertEqual(endpoint.query, [:])
        XCTAssertEqual(endpoint.method, .get)
    }

    func test_user_endpoint_should_have_correct_url_and_method() {
        let endpoint = UserEndpoint.details(id: 1)
        XCTAssertEqual(endpoint.baseURL.absoluteString, "https://jsonplaceholder.typicode.com/users/1")
        XCTAssertEqual(endpoint.path, "/users/1")
        XCTAssertEqual(endpoint.query, [:])
        XCTAssertEqual(endpoint.method, .get)
    }
    
}
