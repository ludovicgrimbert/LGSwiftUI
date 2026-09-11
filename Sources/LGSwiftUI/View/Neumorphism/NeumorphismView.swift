//
//  NeumorphismView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import Foundation
import SwiftUI

public enum NeumorphismLevel {
    case high
    case low
}

public enum NeumorphismType {
    case shadow
    case deep
}

public enum NeumorphismStyle {
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
    case triangle
}

public struct NeumorphismView: View {
    
    public var style: NeumorphismStyle
    public var level: NeumorphismLevel
    public var type:NeumorphismType
    public let width: CGFloat
    public let height: CGFloat
    public let color: Color
    public var shadowColorPrimary: Color
    public var shadowColorSecondary: Color
    
    public init(style: NeumorphismStyle,
                level: NeumorphismLevel,
                type:NeumorphismType,
                width: CGFloat,
                height: CGFloat,
                color: Color,
                shadowColorPrimary: Color = Color.black,
                shadowColorSecondary: Color = Color.white) {
        self.style = style
        self.level = level
        self.type = type
        self.width = width
        self.height = height
        self.color = color
        self.shadowColorPrimary = shadowColorPrimary
        self.shadowColorSecondary = shadowColorSecondary
    }
    
    public var body: some View {
        switch (level, type) {
        case (.high,.shadow): ShapeHighShadow(style: style,
                                              width: width,
                                              height: height,
                                              color: color,
                                              shadowColorPrimary: shadowColorPrimary,
                                              shadowColorSecondary: shadowColorSecondary)
        case (.high,.deep): ShapeHighDeep(style: style,
                                          width: width,
                                          height: height,
                                          color: color,
                                          shadowColorPrimary: shadowColorPrimary)
        case (.low,.shadow): ShapeLowShadow(style: style,
                                            width: width,
                                            height: height,
                                            color: color,
                                            shadowColorPrimary: shadowColorPrimary,
                                            shadowColorSecondary: shadowColorSecondary)
        default:
            // low and deep don't exist
            AnyView(EmptyView())
        }
    }
    
    public static func getShape(style: NeumorphismStyle) -> some Shape {
        // SwiftUI's own `AnyShape` (iOS 16+). The library used to ship a duplicate
        // with the same name, which made the symbol ambiguous in any file importing both.
        switch style {
        case .roundedRectangle(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            return AnyShape(Circle())
        case .triangle:
            return AnyShape(Triangle())
        }
    }
}

public struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
