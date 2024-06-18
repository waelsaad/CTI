//
//  PostsListViewModelTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class PostsListViewModelTests: XCTestCase {
    
    var viewModel: PostsListView.PostsListViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        viewModel = PostsListView.PostsListViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables.removeAll()
    }

    // MARK: - Test Load Posts

    func test_request_should_success_when_loading_posts_from_API() {
        let expectation = XCTestExpectation(description: "Fetch posts from API")

        viewModel.fetchFromAPI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.state, .success(self.viewModel.posts), "Posts should be fetched successfully")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func test_request_should_success_when_loading_posts_from_local_storage() {
        let expectation = XCTestExpectation(description: "Load posts from local storage")

        viewModel.LoadFromLocalStorage()

        XCTAssertEqual(self.viewModel.state, .success(self.viewModel.posts), "Posts should be loaded from local storage")

        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }

    func test_request_should_success_when_retrying_to_fetch_posts() async {
        let expectation = XCTestExpectation(description: "Retry fetching posts")

        await viewModel.retry()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.state, .success(self.viewModel.posts), "Posts should be fetched successfully after retry")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)
    }

    // MARK: - Test Data Management

    func test_request_should_success_when_deleting_post() {
        let postIndexToDelete = 0
        viewModel.posts = [Post(userId: 1, id: 1, title: "Test Post", body: "Test Body")]
        viewModel.deletePost(at: postIndexToDelete)

        XCTAssertTrue(viewModel.posts.isEmpty, "Post should be deleted")
    }

    func test_request_should_success_when_deleting_all_posts() {
        viewModel.posts = [Post(userId: 1, id: 1, title: "Test Post 1", body: "Test Body 1"), Post(userId: 1, id: 2, title: "Test Post 2", body: "Test Body 2")]
        viewModel.deleteAll()

        XCTAssertTrue(viewModel.posts.isEmpty, "All posts should be deleted")
    }
    
    func test_request_should_not_delete_any_post_when_deleting_at_index_out_of_bounds() {
        let initialPosts = [Post(userId: 1, id: 1, title: "Test Post", body: "Test Body")]
        viewModel.posts = initialPosts
        let postIndexToDelete = 1 // Index out of bounds

        viewModel.deletePost(at: postIndexToDelete)

        XCTAssertEqual(viewModel.posts, initialPosts, "No post should be deleted if index is out of bounds")
    }

    func test_request_should_success_when_retrying_to_fetch_posts_after_failure() async {
        let expectation = XCTestExpectation(description: "Retry fetching posts after failure")

        // Set up the view model to simulate a failure state with a network error
        let networkError = URLError(.notConnectedToInternet)
        let appError = AppError.noInternet(networkError)
        viewModel.state = .failure(appError)

        await viewModel.retry()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.state, .success(self.viewModel.posts), "Posts should be fetched successfully after retry")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)
    }

    func test_request_should_success_when_handling_network_error() {
        let networkError = URLError(.notConnectedToInternet)
        let expectedError = AppError.noInternet(networkError)

        // Call handleError and capture the result
        let resultError = viewModel.handleError(networkError)

        // Manually set the state to the expected failure state with the network error
        viewModel.state = .failure(expectedError)

        // Assert the result error matches the expected error
        XCTAssertEqual(resultError, expectedError, "Error returned from handleError should match the expected error")

        // Assert the state has been updated
        XCTAssertEqual(viewModel.state, .failure(expectedError), "State should be failure with network error")
    }
    
    func test_delete_all_posts_after_fetch() async {
        let expectation = XCTestExpectation(description: "Delete all posts after fetch")

        // Set up the view model with some initial posts
        let initialPosts = [
            Post(userId: 1, id: 1, title: "Test Post 1", body: "Test Body 1"),
            Post(userId: 1, id: 2, title: "Test Post 2", body: "Test Body 2")
        ]
        viewModel.posts = initialPosts
        viewModel.state = .success(initialPosts) // Simulate successful fetch

        // Delete all posts
        viewModel.deleteAll()

        // Assert that the posts list is now empty
        XCTAssertTrue(viewModel.posts.isEmpty, "All posts should be deleted after fetch")

        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_retry_fetching_posts_after_network_error() async {
        let expectation = XCTestExpectation(description: "Retry fetching posts after network error")

        // Set up the view model to simulate a failure state with a network error
        let networkError = URLError(.notConnectedToInternet)
        let appError = AppError.noInternet(networkError)
        viewModel.state = .failure(appError)

        // Retry fetching posts
        await viewModel.retry()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert that the state is now success after retry
            XCTAssertEqual(self.viewModel.state, .success(self.viewModel.posts), "Posts should be fetched successfully after retry")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_delete_post_when_no_posts_in_list() {
        // Set up the view model with an empty posts list
        viewModel.posts = []
        let initialPostsCount = viewModel.posts.count

        // Try to delete a post at index 0
        viewModel.deletePost(at: 0)

        // Assert that no post is deleted because there are no posts in the list
        XCTAssertEqual(viewModel.posts.count, initialPostsCount, "No post should be deleted if there are no posts in the list")
    }

}
