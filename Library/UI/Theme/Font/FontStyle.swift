//
//  FontStyle.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

protocol FontStyle {
	var name: String { get }
}

extension FontStyle {

	func font(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {

		if let textStyle = textStyle {
			return Font.custom(name, size: size, relativeTo: textStyle)
		} else {
			return Font.custom(name, fixedSize: size)
		}
	}

}
