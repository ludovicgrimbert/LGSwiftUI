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

/// The three neumorphic treatments the library renders. Replaces the
/// `(NeumorphismLevel, NeumorphismType)` pair, whose fourth combination (`.low`, `.deep`)
/// had no rendering.
public enum NeumorphismEffect: Sendable, Equatable {
    /// Raised element: wide soft shadows (radius 10).
    case highShadow
    /// Raised element with a blurred inner-stroke gradient instead of drop shadows.
    case highDeep
    /// Slightly raised element: tight shadows (radius 3).
    case lowShadow

    /// `nil` for the (`.low`, `.deep`) combination, which has never rendered anything.
    public init?(level: NeumorphismLevel, type: NeumorphismType) {
        switch (level, type) {
        case (.high, .shadow): self = .highShadow
        case (.high, .deep): self = .highDeep
        case (.low, .shadow): self = .lowShadow
        case (.low, .deep): return nil
        }
    }
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
    public var effect: NeumorphismEffect?
    public let width: CGFloat?
    public let height: CGFloat?
    public let color: Color
    public var shadowColorPrimary: Color
    public var shadowColorSecondary: Color

    /// Backwards-compatible convenience: the effect is `.highShadow` for (`.high`, `.shadow`),
    /// `.highDeep` for (`.high`, `.deep`), `.lowShadow` for (`.low`, `.shadow`).
    public var level: NeumorphismLevel {
        switch effect {
        case .highShadow, .highDeep, nil: .high
        case .lowShadow: .low
        }
    }

    /// See ``level``.
    public var type: NeumorphismType {
        switch effect {
        case .highShadow, .lowShadow, nil: .shadow
        case .highDeep: .deep
        }
    }

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

    /// Original initializer, kept for source compatibility. The (`.low`, `.deep`)
    /// combination renders nothing, as it always did; prefer
    /// ``init(style:effect:width:height:color:shadowColorPrimary:shadowColorSecondary:)``
    /// where that case cannot be expressed.
    public init(style: NeumorphismStyle,
                level: NeumorphismLevel,
                type: NeumorphismType,
                width: CGFloat,
                height: CGFloat,
                color: Color,
                shadowColorPrimary: Color = Color.black,
                shadowColorSecondary: Color = Color.white) {
        self.style = style
        self.effect = NeumorphismEffect(level: level, type: type)
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
        case nil:
            EmptyView()
        }
    }

    @available(*, deprecated, message: "Use NeumorphismStyle.shape instead")
    public static func getShape(style: NeumorphismStyle) -> some Shape {
        style.shape
    }
}

// MARK: - Modifier

/// Draws a ``NeumorphismView`` behind the content.
///
/// Without `width`/`height` the shape takes the content's size; with them the content is
/// framed first, which is pixel-identical to the `ZStack { NeumorphismView(width:height:); content }`
/// composition the apps have been writing by hand:
///
/// ```swift
/// Text("Back")
///     .textStyle(H5Style())
///     .neumorphic(.roundedRectangle(cornerRadius: theme.smallValue), effect: .lowShadow,
///                 width: theme.largeValue, height: theme.mediumValue)
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
