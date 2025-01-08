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

public struct CustomTextFieldStyle: TextFieldStyle {
    var color: Color
    var font: Font
    var cornerRadius: CGFloat
    var strokeColor: Color
    var lineWidth: CGFloat

    public init(color: Color,
                font: Font,
                cornerRadius: CGFloat = 0,
                strokeColor: Color = .clear,
                lineWidth: CGFloat = 1) {
        self.color = color
        self.font = font
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth

    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(color)
            .font(font)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}
