//
//  CommentsEndPointTests.swift
//  JSONSuiteUITests
//
//  Created by Wael Saad on 3/5/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import XCTest
import Combine
@testable import JSONSuite

// swiftlint:disable implicitly_unwrapped_optional test_case_accessibility

final class PostsListViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLoadingView() throws {
        // Simulate loading state
        app.launchArguments.append("-LoadingState")
        app.launch()
        
        // Verify loading view is displayed
        XCTAssertTrue(app.otherElements["LoadingView"].exists)
    }
    
    func testSuccessView() throws {
        // Simulate success state
        app.launchArguments.append("-SuccessState")
        app.launch()
        
        // Verify success view is displayed
        XCTAssertTrue(app.otherElements["SuccessView"].exists)
    }
    
    func testErrorView() throws {
        // Simulate failure state
        app.launchArguments.append("-FailureState")
        app.launch()
        
        // Verify error view is displayed
        XCTAssertTrue(app.otherElements["ErrorView"].exists)
    }
    
    func testTapPost() throws {
        // Simulate success state
        app.launchArguments.append("-SuccessState")
        app.launch()
        
        // Tap on a post in the list
        let firstPost = app.tables.cells.firstMatch
        firstPost.tap()
        
        // Verify navigation to post details view
        XCTAssertTrue(app.otherElements["PostDetailsView"].exists)
    }
    
    func testDeletePost() throws {
        // Simulate success state
        app.launchArguments.append("-SuccessState")
        app.launch()
        
        // Swipe to reveal delete button
        let firstPost = app.tables.cells.firstMatch
        let deleteButton = firstPost.buttons["Delete"]
        firstPost.swipeLeft()
        
        // Tap on delete button
        deleteButton.tap()
        
        // Verify post is deleted
        XCTAssertFalse(app.tables.cells.firstMatch.exists)
    }
    
    func testDeleteAllPosts() throws {
        // Simulate success state
        app.launchArguments.append("-SuccessState")
        app.launch()
        
        // Tap on delete all button
        let deleteAllButton = app.navigationBars.buttons["Delete All"]
        deleteAllButton.tap()
        
        // Confirm deletion
        app.buttons["Delete"].tap()
        
        // Verify all posts are deleted
        XCTAssertFalse(app.tables.cells.firstMatch.exists)
    }
    
}
