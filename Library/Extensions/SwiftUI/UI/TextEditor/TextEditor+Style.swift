//
//  TextEditor.swift
//  Library
//
//  Created by Wael Saad on 2/5/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation
import SwiftUI

extension TextEditor {
    
    func styleEditor(minHeight: CGFloat, maxHeight: CGFloat) -> some View {
        self.padding(.bottom)
            .background(Color.white.opacity(0.1))
            .foregroundColor(.black)
            .disableAutocorrection(true)
            .font(.montserrat.bold(size: 20))
            .scrollContentBackground(.hidden)
            .multilineTextAlignment(.leading)
            .frame(minHeight: minHeight)
            .frame(maxHeight: maxHeight)
    }
    
}
