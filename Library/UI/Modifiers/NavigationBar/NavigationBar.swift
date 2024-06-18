//
//  NavigationBarModifier.swift
//  Library
//
//  Created by Wael Saad on 4/7/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavigationBar: ViewModifier {
    enum Mode {
        case test
        case clear
        case blue
    }
    
    var mode: Mode
    var backgroundColor: UIColor?
    
    @State private var currentColorScheme: ColorScheme
    
    @Environment(\.colorScheme) private var colorScheme
    
    init(_ mode: Mode) {
        self.mode = mode
        _currentColorScheme = State(initialValue: .light)
        set(mode)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .environment(\.colorScheme, colorScheme)
            VStack {
                GeometryReader { geometry in
                    Color(backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
        .onAppear {
            updateNavigationBar()
        }
    }
    
    static func set(_ mode: Mode) {
        let navigationBar = NavigationBar(mode)
        navigationBar.set(mode)
    }
    
    func set(_ mode: Mode) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        switch mode {
        case .test:
            applyTestModeStyle(to: appearance)
        case .clear:
            applyClearModeStyle(to: appearance)
        case .blue:
            applyBlueModeStyle(to: appearance)
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func applyClearModeStyle(to appearance: UINavigationBarAppearance) {
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    private func applyTestModeStyle(to appearance: UINavigationBarAppearance) {
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(Color.red)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
        UINavigationBar.appearance().tintColor = UIColor(.orange)
        UINavigationBar.appearance().barTintColor = UIColor(.green)
    }
    
    private func applyBlueModeStyle(to appearance: UINavigationBarAppearance) {
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        let topColor = UIColor(Color.Palette.primary)
        let bottomColor = UIColor(Color.Palette.secondary)
        appearance.backgroundImage = UIImage.getImageGradient(topColor: topColor, bottomColor: bottomColor)
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
//    private func applyBlueModeStyle1(to appearance: UINavigationBarAppearance) {
//        appearance.backgroundColor = .clear
//        appearance.shadowColor = .clear
//        let backgroundImage = UIImage(named: "navigation_bar")
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundImage = backgroundImage
//        UINavigationBar.appearance().standardAppearance = appearance
//    }
    
    private func updateNavigationBar() {
        
    }
}

extension View {
    func navigationBar(_ mode: NavigationBar.Mode) -> some View {
        modifier(NavigationBar(mode))
            .onAppear {
                NavigationBar(mode).set(mode)
            }
    }
}
