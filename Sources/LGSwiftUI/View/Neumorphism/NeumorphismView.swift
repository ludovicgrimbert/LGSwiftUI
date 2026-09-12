//
//  NeumorphismView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import Foundation
import SwiftUI

/// The three neumorphic treatments the library renders.
public enum NeumorphismEffect: Sendable, Equatable {
    /// Raised element: wide soft shadows (radius 10).
    case highShadow
    /// Raised element with a blurred inner-stroke gradient instead of drop shadows.
    case highDeep
    /// Slightly raised element: tight shadows (radius 3).
    case lowShadow
}

public enum NeumorphismStyle: Sendable, Equatable {
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
    case triangle

    /// The `Shape` this style draws. Uses SwiftUI's `AnyShape` (iOS 16+).
    public var shape: AnyShape {
        switch self {
        case .roundedRectangle(let cornerRadius):
            AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            AnyShape(Circle())
        case .triangle:
            AnyShape(Triangle())
        }
    }
}

/// A neumorphic shape. With an explicit `width`/`height` it is a fixed-size element to
/// compose in a `ZStack`; without them it fills whatever size it is proposed, which is
/// what ``SwiftUI/View/neumorphic(_:effect:color:width:height:shadowColorPrimary:shadowColorSecondary:)``
/// relies on to size the shape to its content.
public struct NeumorphismView: View {

    public var style: NeumorphismStyle
    public var effect: NeumorphismEffect
    public let width: CGFloat?
    public let height: CGFloat?
    public let color: Color
    public var shadowColorPrimary: Color
    public var shadowColorSecondary: Color

    public init(style: NeumorphismStyle,
                effect: NeumorphismEffect,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                color: Color,
                shadowColorPrimary: Color = Color.black,
                shadowColorSecondary: Color = Color.white) {
        self.style = style
        self.effect = effect
        self.width = width
        self.height = height
        self.color = color
        self.shadowColorPrimary = shadowColorPrimary
        self.shadowColorSecondary = shadowColorSecondary
    }

    public var body: some View {
        switch effect {
        case .highShadow:
            ShapeHighShadow(style: style,
                            width: width,
                            height: height,
                            color: color,
                            shadowColorPrimary: shadowColorPrimary,
                            shadowColorSecondary: shadowColorSecondary)
        case .highDeep:
            ShapeHighDeep(style: style,
                          width: width,
                          height: height,
                          color: color,
                          shadowColorPrimary: shadowColorPrimary)
        case .lowShadow:
            ShapeLowShadow(style: style,
                           width: width,
                           height: height,
                           color: color,
                           shadowColorPrimary: shadowColorPrimary,
                           shadowColorSecondary: shadowColorSecondary)
        }
    }
}

// MARK: - Modifier

/// Draws a ``NeumorphismView`` behind the content.
///
/// Without `width`/`height` the shape takes the content's size; with them the content is
/// framed first. Prefer `.frame(minWidth:minHeight:)` on the content and no explicit size
/// here when the content is text: identical when it fits, and it can grow.
///
/// ```swift
/// Text("Back")
///     .textStyle(.h5)
///     .frame(minWidth: theme.size.l, minHeight: theme.size.m)
///     .neumorphic(.roundedRectangle(cornerRadius: theme.radius.m), effect: .lowShadow)
/// ```
///
/// `color` defaults to the theme's primary background for the current colour scheme.
public struct NeumorphicModifier: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var style: NeumorphismStyle
    var effect: NeumorphismEffect
    var color: Color?
    var width: CGFloat?
    var height: CGFloat?
    var shadowColorPrimary: Color
    var shadowColorSecondary: Color

    public nonisolated init(style: NeumorphismStyle,
                            effect: NeumorphismEffect,
                            color: Color? = nil,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            shadowColorPrimary: Color = .black,
                            shadowColorSecondary: Color = .white) {
        self.style = style
        self.effect = effect
        self.color = color
        self.width = width
        self.height = height
        self.shadowColorPrimary = shadowColorPrimary
        self.shadowColorSecondary = shadowColorSecondary
    }

    public func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(
                NeumorphismView(style: style,
                                effect: effect,
                                color: color ?? (colorScheme == .light ? theme.lightPrimaryBackgroundColor : theme.darkPrimaryBackgroundColor),
                                shadowColorPrimary: shadowColorPrimary,
                                shadowColorSecondary: shadowColorSecondary)
            )
    }
}

public extension View {
    /// See ``NeumorphicModifier``.
    func neumorphic(_ style: NeumorphismStyle,
                    effect: NeumorphismEffect,
                    color: Color? = nil,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil,
                    shadowColorPrimary: Color = .black,
                    shadowColorSecondary: Color = .white) -> some View {
        modifier(NeumorphicModifier(style: style,
                                    effect: effect,
                                    color: color,
                                    width: width,
                                    height: height,
                                    shadowColorPrimary: shadowColorPrimary,
                                    shadowColorSecondary: shadowColorSecondary))
    }
}

// MARK: - Shapes

public struct Triangle: Shape {
    public init() {}

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
