//
//  ShapeHighDeep.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import Foundation
import SwiftUI

public struct ShapeHighDeep: View {
    public let style : NeumorphismStyle
    public let width: CGFloat
    public let height: CGFloat
    public let color: Color
    public var shadowColorPrimary: Color
    
    public var shape: some Shape {
        return NeumorphismView.getShape(style: style)
    }
    
    public var body: some View {
        shape
            .fill(color)
            .frame(width: width, height: height)
            .overlay(
                shape
                    .stroke(Color.gray, lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(shape.fill(LinearGradient(gradient: Gradient(colors: [shadowColorPrimary, Color.clear]), startPoint: .leading, endPoint: .trailing)))
            )
            .overlay(
                shape
                    .stroke(Color.white, lineWidth: 8)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(shape.fill(LinearGradient(gradient: Gradient(colors: [Color.clear, shadowColorPrimary]), startPoint: .leading, endPoint: .trailing)))
            )
    }
}
