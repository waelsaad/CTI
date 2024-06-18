//
//  PostDetailsViewModelTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class PostDetailsViewModelTests: XCTestCase {
    
    var viewModel: PostDetailsView.PostDetailsViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body")
        viewModel = PostDetailsView.PostDetailsViewModel(post: post)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables.removeAll()
    }

    func test_loadAuthor_should_success() async {
        let expectation = XCTestExpectation(description: "Load post author")

        // Simulate a successful author fetch
        let user = User(id: 1, name: "Test User", username: "testuser", email: "test@test.com", phone: "123456789", website: "www.test.com", company: Company(name: "Test Company", catchPhrase: "Test Catch Phrase", bs: "Test BS"), address: Address(street: "Test Street", city: "Test City", zipcode: "12345", suite: "Test Suite"))

        // Replace the userService with a mock that returns the user immediately
        let mockUserService = MockUserService(user: user)
        viewModel.userService = mockUserService

        // Call loadAuthor asynchronously
        Task {
            await viewModel.loadAuthor()

            // Check the state after a delay to allow time for loadAuthor() to complete
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.state, .success, "Author should be loaded successfully")
                XCTAssertFalse(self.viewModel.showErrorView, "Error view should not be shown")

                expectation.fulfill()
            }
        }

        // Wait for the expectation to be fulfilled
        await fulfillment(of: [expectation], timeout: 15)
    }

    func test_loadComments_should_success() async {
        let expectation = XCTestExpectation(description: "Load post comments")

        // Simulate successful comments fetch
        let comments = [
            Comment(postId: 1, id: 1, name: "Test Comment 1", email: "test1@test.com", body: "Comment Body 1"),
            Comment(postId: 1, id: 2, name: "Test Comment 2", email: "test2@test.com", body: "Comment Body 2")
        ]

        // Replace the commentsService with a mock that returns the comments immediately
        let mockCommentsService = MockCommentsService(comments: comments)
        viewModel.commentsService = mockCommentsService

        // Call loadComments asynchronously
        Task {
            await viewModel.loadComments()

            // Check the state after a delay to allow time for loadComments() to complete
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.state, .success, "Comments should be loaded successfully")
                XCTAssertFalse(self.viewModel.showErrorView, "Error view should not be shown")

                expectation.fulfill()
            }
        }

        // Wait for the expectation to be fulfilled
        await fulfillment(of: [expectation], timeout: 15)
    }

    func test_retryAction_should_success() async {
        let expectation = XCTestExpectation(description: "Retry action")

        // Simulate successful author and comments fetches
        let user = User(id: 1, name: "Test User", username: "testuser", email: "test@test.com", phone: "123456789", website: "www.test.com", company: Company(name: "Test Company", catchPhrase: "Test Catch Phrase", bs: "Test BS"), address: Address(street: "Test Street", city: "Test City", zipcode: "12345", suite: "Test Suite"))
        let comments = [
            Comment(postId: 1, id: 1, name: "Test Comment 1", email: "test1@test.com", body: "Comment Body 1"),
            Comment(postId: 1, id: 2, name: "Test Comment 2", email: "test2@test.com", body: "Comment Body 2")
        ]

        // Replace the userService and commentsService with mocks that return data immediately
        let mockUserService = MockUserService(user: user)
        viewModel.userService = mockUserService

        let mockCommentsService = MockCommentsService(comments: comments)
        viewModel.commentsService = mockCommentsService

        // Call retryAction asynchronously
        Task {
            await viewModel.retryAction()

            // Check the state after a delay to allow time for the retryAction to complete
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.state, .success, "Retry action should fetch author and comments successfully")
                XCTAssertFalse(self.viewModel.showErrorView, "Error view should not be shown")

                expectation.fulfill()
            }
        }

        // Wait for the expectation to be fulfilled
        await fulfillment(of: [expectation], timeout: 15)
    }
    
}
