//
//  RouterView.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

/// The RouterView is a warpper for the view to manage the navigation and view heirarchy and loosly couple views from each other.

struct RouterView<Content: View>: View {
    
    /// Observes updates to the route.
    @ObservedObject var router: Router
    
    /// The View Content.
    private let content: Content
    
    init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        self.router = router
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                UI.gradient
                    .edgesIgnoringSafeArea(.all)
                content
                    .navigationDestination(for: Router.Route.self) { route in
                        router.view(for: route)
                    }
            }
        }
        .environmentObject(router)
    }
    
}
