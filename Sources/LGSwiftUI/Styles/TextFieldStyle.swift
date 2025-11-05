//
//  TextFieldStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 08/01/2025.
//

import SwiftUI

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
            .tint(color)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}
