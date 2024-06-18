//
//  NavRow.swift
//  Library
//
//  Created by Wael Saad on 1/5/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavRow: View {

    let image: Image?
    let title: String
    var subTitle: String?
    var trailingText: String?
    let position: Position
    let color: Color?
    let isInSheet: Bool

    // swiftlint:disable function_default_parameter_at_end
    
    init(title: String, image: Image? = nil, subTitle: String? = nil, trailingText: String? = nil, color: Color? = nil, isInSheet: Bool = false, position: Position) {
        self.title = title
        self.subTitle = subTitle
        self.trailingText = trailingText
        self.image = image
        self.color = color
        self.position = position
        self.isInSheet = isInSheet
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                content
                Spacer()
                DisclosureIndicator()
            }
            .padding(.horizontal)
            .padding([.top, .bottom])
            .contentShape(Rectangle())
            .frame(alignment: .center)
            Color
                .navLinkDivider.frame(height: 2).opacity(0.3)
        }
    }
    
    private var content: some View {
        HStack {
            imageContent
            titleAndSubTitleContent
            trailingTextContent
        }
        .contentShape(Rectangle())
        .frame(maxHeight: .infinity, alignment: .center)
    }

    @ViewBuilder
    private var imageContent: some View {
        if let image = image {
            if let color = color {
                BoxedImage(image: image, foregroundColour: color)
            } else {
                BoxedImage(image: image)
            }
        }
    }

    @ViewBuilder
    private var titleAndSubTitleContent: some View {
        VStack(alignment: .leading, spacing: UI.Space.xxxSmall) {
            Text(title)
                .bold()
                .fontWeight(.bold)
                .foregroundColor(.Text.Post.title)
                .font(.montserrat.regular(size: UI.FontSize.NavRow.title))
                .fixedSize(horizontal: false, vertical: true)
            
            if let subTitle = subTitle, !subTitle.isEmpty {
                Spacer()
                Text(subTitle)
                    .foregroundColor(.Text.Post.subTitle)
                    .font(.montserrat.regular(size: UI.FontSize.NavRow.subTitle))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    @ViewBuilder
    private var trailingTextContent: some View {
        if let trailingText = trailingText, !trailingText.isEmpty {
            Spacer()
            Text(trailingText)
                .foregroundColor(.Text.Post.subTitle)
                .font(.montserrat.regular(size: UI.FontSize.NavRow.subTitle))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.trailing)
        }
    }

}
