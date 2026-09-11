//
//  ShapeLowShadow.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import Foundation
import SwiftUI

public struct ShapeLowShadow: View {
    public let style: NeumorphismStyle
    /// `nil` lets the shape fill the proposed size.
    public let width: CGFloat?
    public let height: CGFloat?
    public let color: Color
    public var shadowColorPrimary: Color
    public var shadowColorSecondary: Color

    public init(style: NeumorphismStyle,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                color: Color,
                shadowColorPrimary: Color,
                shadowColorSecondary: Color) {
        self.style = style
        self.width = width
        self.height = height
        self.color = color
        self.shadowColorPrimary = shadowColorPrimary
        self.shadowColorSecondary = shadowColorSecondary
    }

    public var body: some View {
        style.shape
            .fill(color)
            .frame(width: width, height: height)
            .shadow(color: shadowColorPrimary.opacity(0.2), radius: 3, x: 3, y: 3)
            .shadow(color: shadowColorSecondary.opacity(0.7), radius: 3, x: -1, y: -1)
    }
}
