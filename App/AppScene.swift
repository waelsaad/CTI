//
//  AppScene.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct AppScene: App {
    
    @ObservedObject var viewModel = AppScene.AppViewModel()
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    private var background: some View { UI.gradient }
    
    private let postsList = PostsListView.PostsListViewModel()
    
    init() {
        
    }

    var body: some Scene {
        WindowGroup {
            let router = Router(postsList: postsList)
            NavigationView {
                RouterView(router: router) {
                    router.view(for: .postsListView)
                }
            }
            .navigationBar(.clear)
            .navigationViewStyle(.stack)
            .modelContainer(sharedModelContainer)
            .toolbarBackground(.indigo, for: .navigationBar)
        }
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Post.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
}
