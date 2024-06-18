//
//  UI.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import UIKit
import SwiftUI

// swiftlint:disable nesting

enum UI {

    enum IconSize {
        static let standard = 24.0
        static let listItemIcon = 24.0
        static let categoryIcon = 30.0
        static let searchIcon = 20.0
    }
    
    enum Error {
        enum Logo {
            static let width = 160.0
            static let height = 160.0
            static let top = 30.0
            static let bottom = 50.0
        }
        
        enum Image {
            static let width = 240.0
        }
        
        enum Description {
            static let bottom = 30.0
        }
        enum RetryButton {
            static let height = 50.0
            static let cornerRadius = 10.0
            static let horizontal = 50.0
        }
    }
    
    enum Dimensions {
        static let circleRadius = 16.0
        
        enum Logo {
            static let width = 70.0
        }
        
        enum PostItem {
            static let rowHeight = 60.0
        }
        
        enum LoadingView {
            static let scaleEffect = 1.7
        }
        
        static let minHeight = 110.0
        static let maxHeight = 348.0
        static let miniHeaderHeight = 80.0
    }
    
    enum Space {
        
        static let xxxSmall = 5.0
        static let xxSmall = 15.0
        static let xSmall = 20.0
        static let small = 30.0
        static let medium = 42.0
        static let large = 44.0
        static let xLarge = 52.0
        static let xxLarge = 80.0
  
    }
    
    enum FormField {
        
        enum Title {
            static let minHeight = 100.0
            static let maxHeight = 100.0
        }
        
        enum Body {
            static let minHeight = 100.0
            static let maxHeight = 250.0
        }
        
    }
    
    enum Padding {
        
        static let xSmall = 20.0
        static let small = 30.0
        
        enum Title {
            static let leading = 24.0
            static let yOffset = 40.0
        }
        
        enum Navigation {
            
            enum Button {
                static let vertical = 5.0
                static let horizontal = 15.0
                static let cornerRadius = 15.0
            }
            
            enum Badge {
                static let radius = 40.0
                static let borderWidth = 2.0
            }
            
            static let yOffset = 100.0
            
        }
        
        enum NoItemsView {
            static let top = 250.0
        }
        
        enum PostItemView {
            static let vertical = 7.0
            static let horizontal = 20.0
        }
        
        enum PostEditItem {
            static let top = 10.0
        }
        
        enum LoadingView {
            static let yOffset = -50.0
        }
        
        enum HeaderView {
            static let top = 45.0
            static let bottom = 20.0
            static let leading = 10.0
            static let horizontal = 30.0
        }
        
        static let boxedImage = 5.0
        static let topBarTop = 54.0
        static let titleLeading = 80.0

        static let sectionHeaderBottom = 10.0
        static let spaceBetweenIconAndText = 12.0
        
    }
    
    enum FontSize {
        
        enum NavRow {
            static let title = 20.0
            static let subTitle = 15.0
        }
        
        enum PostItemView {
            static let title = 25.0
            static let subTitle = 13.0
        }
        
        enum CommentView {
            static let title = 20.0
            static let subTitle = 13.0
        }
        
        static let title = 30.0
        static let titleInNavigation = 18.0
        static let description = 15.0
        static let secondaryDescription = 13.0
        static let name = 13.0
        static let level = 15.0
        static let sectionHeader = 18.0
        static let listButton = 14.0
        static let commentsCount = 20.0
    }
    
    enum CornerRadius {
        static let button = 4.0
        static let card = 5.0
        static let infoBox = 5.0
        static let container = 10.0
        static let scannerBox = 20.0
        static let brandingCorner = 30.0
    }
    
    enum Opacity {
        static let clear = 0.0
        static let superUltraLight = 0.05
        static let ultralight = 0.1
        static let light: Double = 0.2
        static let scannerBackground = 0.4
        static let pressedButton = 0.3
        static let opaque = 1.0
    }
    
    enum Offset {
        static let logoBackground = -80.0
    }
    
    enum ImageSize {
        static let xxLarge = 180.0
        static let large = 80.0
        static let medium = 50.0
        static let itemIcon = 16.0
        static let small = 40.0
        static let xsmall = 30.0
        static let xxxSmall = 25.0
        static let xxxxSmall = 18.0
        static let iconSize = 20.0
        static let boxedIcon = 25.0
        static let unreadBadge = 8.0
        static let cardHeader = 150.0
		static let qr = 200.0
    }
 
    enum Button {
		static let height = 55.0
		static let minHeight = 30.0
        static let padding = 20.0
        static let cornerRadius = 30.0
        static let shadowRadius = 2.0
        static let shadowYOffset = 1.0
    }

    enum Text {
        static let asSmallAsItNeeds = 0.1
        static let scannerTextFontSize = 20.0
        static let domCovidCertTimer = 16.0
    }
    
    enum CircularSpinner {
        static let large = 60.0
        static let medium = 40.0
        static let small = 17.0
    }
    
}
