//
//  JSONSuiteTests.swift
//  JSONSuiteTests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class PostsDataManagerTests: XCTestCase {
    
    var dataManager: PostsDataManagerProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataManager = PostsDataManager()
    }

    override func tearDownWithError() throws {
        dataManager.deleteAll()
        dataManager = nil
        try super.tearDownWithError()
    }

    func test_insertPost_should_contain_inserted_post() {
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body")
        dataManager.insertPost(post)
        let loadedPosts = dataManager.loadAll()
        XCTAssert(loadedPosts.contains(post))
    }

    func test_deletePost_should_not_contain_deleted_post() {
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body")
        dataManager.insertPost(post)
        dataManager.deletePost(post)
        let loadedPosts = dataManager.loadAll()
        XCTAssertFalse(loadedPosts.contains(post))
    }

    func test_savePosts_should_contain_all_saved_posts() {
        let post1 = Post(userId: 1, id: 1, title: "Test Title 1", body: "Test Body 1")
        let post2 = Post(userId: 1, id: 2, title: "Test Title 2", body: "Test Body 2")
        dataManager.savePosts(posts: [post1, post2])
        let loadedPosts = dataManager.loadAll()
        XCTAssertTrue(loadedPosts.contains(post1))
        XCTAssertTrue(loadedPosts.contains(post2))
    }

    func test_loadAll_should_return_correct_number_of_posts() {
        let post1 = Post(userId: 1, id: 1, title: "Test Title 1", body: "Test Body 1")
        let post2 = Post(userId: 1, id: 2, title: "Test Title 2", body: "Test Body 2")
        dataManager.savePosts(posts: [post1, post2])
        let loadedPosts = dataManager.loadAll()
        XCTAssertEqual(loadedPosts.count, 2)
        XCTAssertTrue(loadedPosts.contains(post1))
        XCTAssertTrue(loadedPosts.contains(post2))
    }

    func test_deleteAll_should_remove_all_posts() {
        let post1 = Post(userId: 1, id: 1, title: "Test Title 1", body: "Test Body 1")
        let post2 = Post(userId: 1, id: 2, title: "Test Title 2", body: "Test Body 2")
        dataManager.savePosts(posts: [post1, post2])
        dataManager.deleteAll()
        let loadedPosts = dataManager.loadAll()
        XCTAssertTrue(loadedPosts.isEmpty)
    }

}
