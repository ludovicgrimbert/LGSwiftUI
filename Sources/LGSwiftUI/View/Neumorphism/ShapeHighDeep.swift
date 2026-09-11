//
//  ShapeHighDeep.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import Foundation
import SwiftUI

public struct ShapeHighDeep: View {
    public let style: NeumorphismStyle
    /// `nil` lets the shape fill the proposed size.
    public let width: CGFloat?
    public let height: CGFloat?
    public let color: Color
    /// Drives the two gradient masks (opaque on one side, transparent on the other).
    public var shadowColorPrimary: Color
    /// Colour of the blurred stroke on the bottom-right side. Historically hardcoded.
    public var deepStrokeDarkColor: Color
    /// Colour of the blurred stroke on the top-left side. Historically hardcoded.
    public var deepStrokeLightColor: Color

    public init(style: NeumorphismStyle,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                color: Color,
                shadowColorPrimary: Color,
                deepStrokeDarkColor: Color = .gray,
                deepStrokeLightColor: Color = .white) {
        self.style = style
        self.width = width
        self.height = height
        self.color = color
        self.shadowColorPrimary = shadowColorPrimary
        self.deepStrokeDarkColor = deepStrokeDarkColor
        self.deepStrokeLightColor = deepStrokeLightColor
    }

    private var shape: AnyShape { style.shape }

    public var body: some View {
        shape
            .fill(color)
            .frame(width: width, height: height)
            .overlay(
                shape
                    .stroke(deepStrokeDarkColor, lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(shape.fill(LinearGradient(gradient: Gradient(colors: [shadowColorPrimary, Color.clear]), startPoint: .leading, endPoint: .trailing)))
            )
            .overlay(
                shape
                    .stroke(deepStrokeLightColor, lineWidth: 8)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(shape.fill(LinearGradient(gradient: Gradient(colors: [Color.clear, shadowColorPrimary]), startPoint: .leading, endPoint: .trailing)))
            )
    }
}
