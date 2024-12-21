//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct CustomIconLabelStyle: LabelStyle {
    @Environment(\.theme) var theme

    
    public init(color: Color, size: CGFloat) {
        self.color = color
        self.size = size
    }
    var color: Color
    var size: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .imageScale(.small)
                .foregroundColor(theme.darkTextColor)
                .background(RoundedRectangle(cornerRadius: 7 * size).frame(width: 28 * size, height: 28 * size).foregroundColor(color))
        }
    }
}
