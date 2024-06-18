//
//  View+ButtolStyles.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

enum ButtonState {
    case enabled
    case pressed
    case loading
    case disabled
}

extension View {

    func style(
        foreground: Color = Color.white,
        primaryImage: AppImage? = nil,
        secondaryImage: AppImage? = nil,
        systemName: String? = nil,
        systemImage: SystemImage? = nil,
        _ style: ImageStyle = .standard
    ) -> some View {
        self.buttonStyle(
            ButtonImage(
                primaryImage: primaryImage,
                secondaryImage: secondaryImage,
                systemName: systemName,
                systemImage: systemImage,
                foreground: foreground,
                style: style,
                width: UI.ImageSize.xsmall,
                height: UI.ImageSize.xsmall
            )
        )
    }
    
    func editStyleX(progress: CGFloat) -> some View {
        self.buttonStyle(ButtonImage(primaryImage: .edit, secondaryImage: .edit_clear, progress: progress, width: 73.0, height: 30.0))
    }
    
    func editStyle() -> some View {
        self.buttonStyle(CapsuleButtonStyle(imageName: SystemImage.pencil.rawValue, text: GlobalContent.edit, progress: 1))
    }
    
    func moreStyle(progress: CGFloat) -> some View {
        self.buttonStyle(CircleButtonStyle(imageName: SystemImage.ellipsis.rawValue, progress: progress))
    }
    
    func backStyle() -> some View {
        self.buttonStyle(CircleButtonStyle(imageName: SystemImage.chevronLeft.rawValue, progress: 1))
    }
    
    func deleteAllStyle() -> some View {
        self.buttonStyle(ButtonImage(systemImage: .trash))
    }
    
    func close(color: Color = .Button.close) -> some View {
        self.buttonStyle(ButtonImage(systemName: "xmark.circle.fill", foreground: color))
    }
    
    func saveButton() -> some View {
        self.buttonStyle(PrimaryButtonStyle(background: .Button.save))
    }
    
    func deleteButton() -> some View {
        self.buttonStyle(PrimaryButtonStyle(background: .Button.delete))
    }
    
    func deleteButtonX(color: Color = .Button.delete) -> some View {
        self.buttonStyle(ButtonImage(systemName: "trash", foreground: color))
    }
    
}
