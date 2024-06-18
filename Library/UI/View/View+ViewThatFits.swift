//
//  View+ViewThatFits.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct ViewThatFitsModifier: ViewModifier {

    func body(content: Content) -> some View {
        ViewThatFits(in: .vertical) {
            content
            ScrollView(.vertical, showsIndicators: false) { content }
        }
    }
    
}

extension View {
    
    func viewThatFits() -> some View {
        self.modifier(ViewThatFitsModifier())
    }
    
}
