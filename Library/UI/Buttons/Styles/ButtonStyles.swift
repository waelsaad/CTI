//
//  PrimaryButtonStyle.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: Form Button Style

struct PrimaryButtonStyle: ButtonStyle {
	var background = Color.white
	var cornerRadius = UI.Button.cornerRadius
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.frame(maxWidth: .infinity)
			.background(background)
			.foregroundColor(.white)
			.frame(minHeight: UI.Button.minHeight)
			.cornerRadius(cornerRadius)
			.padding(.horizontal, UI.Button.padding)
			.scaleEffect(configuration.isPressed ? 0.93 : 1.0)
			.shadow(color: .black, radius: UI.Button.shadowRadius, x: 0, y: UI.Button.shadowYOffset)
	}
}
