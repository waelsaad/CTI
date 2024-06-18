//
//  BoxedImage.swift
//  Library
//
//  Created by Wael Saad on 12/8/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension UIRectCorner {
    /// Top corners.
    ///
    /// Includes `topLeft` and  `topRight`.
    static var topCorners: UIRectCorner { [.topLeft, .topRight] }
    
    /// Right corners.
    ///
    /// Includes `topRight` and  `bottomRight`.
    static var rightCorners: UIRectCorner { [.topRight, .bottomRight] }
    
    /// Bottom corners.
    ///
    /// Includes `bottomLeft` and  `bottomRight`.
    static var bottomCorners: UIRectCorner { [.bottomLeft, .bottomRight] }
    
    /// Left corners.
    ///
    /// Includes `topLeft` and  `bottomLeft`.
    static var leftCorners: UIRectCorner { [.topLeft, .bottomLeft] }
    
}

extension View {
    
    /// Clips this `View` to its bounding frame, with the specified corners and corner radius.
    ///
    ///     Color.accentColor
    ///         .frame(dimension: 100)
    ///         .cornerRadius(10, corners: .allCorners)
    ///
    
    func cornerRadius(
        _ radius: CGFloat,
        _ corners: UIRectCorner
    ) -> some View {
        self
            .clipShape(RoundedCorner(radius: radius, corners: corners))
            // .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
    
}

struct BoxedImage: View {
    
    let image: Image
    let foregroundColour: Color?
    let fillColour: Color?
    
    @Environment(\.colorScheme) var colorScheme
    @ScaledMetric var scale = 1.0
    
    init(image: Image, foregroundColour: Color? = .clear, fillColour: Color = .clear) {
        self.image = image
        self.foregroundColour = foregroundColour
        self.fillColour = fillColour
    }
    
    var body: some View {
        image
            .resizable()
            .renderingMode(.template)
            .if(foregroundColour != .clear) {
                $0.foregroundColor(foregroundColour)
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: frameSize, height: frameSize)
            .padding(imagePadding)
            .if(fillColour != .clear) {
                $0.background(
                    RoundedRectangle(cornerRadius: UI.CornerRadius.button * scale)
                        .fill(fillColour ?? .clear)
                        .aspectRatio(1, contentMode: .fill)
                )
            }
    }
    
    var frameSize: Double {
        UI.ImageSize.boxedIcon * scale
    }
    
    var imagePadding: Double {
        UI.Padding.boxedImage * scale
    }
}
