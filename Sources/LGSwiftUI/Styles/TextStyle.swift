//
//  TextStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

// MARK: - Role-based text style

/// Applies a ``TextRole``'s font and the theme's text colour for the current colour scheme.
/// The font size scales with Dynamic Type (relative to the role's `relativeTo` text style);
/// at the default setting it is the role's base size.
///
/// ```swift
/// Text("Stations").textStyle(.h5)
/// ```
public struct LGTextStyle: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric private var size: CGFloat

    let role: TextRole

    public nonisolated init(_ role: TextRole) {
        self.role = role
        _size = ScaledMetric(wrappedValue: role.size, relativeTo: role.relativeTo)
    }

    public func body(content: Content) -> some View {
        content
            .font(role.font(size: size))
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

/// Applies a ``TextRole``'s font only (no colour), scaled with Dynamic Type.
public struct LGFontModifier: ViewModifier {
    @ScaledMetric private var size: CGFloat

    let role: TextRole

    public nonisolated init(_ role: TextRole) {
        self.role = role
        _size = ScaledMetric(wrappedValue: role.size, relativeTo: role.relativeTo)
    }

    public func body(content: Content) -> some View {
        content.font(role.font(size: size))
    }
}

public extension View {
    /// See ``LGTextStyle``.
    func textStyle(_ role: TextRole) -> some View {
        modifier(LGTextStyle(role))
    }

    /// See ``LGFontModifier``. Use it where you set the colour yourself.
    func lgFont(_ role: TextRole) -> some View {
        modifier(LGFontModifier(role))
    }
}

// MARK: - Deprecated

public extension Text {
    /// This is `View.modifier(_:)` under another name; use that, or `.textStyle(TextRole)`.
    @available(*, deprecated, message: "Use .textStyle(.h5) (a TextRole) or .modifier(_:)")
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

// The 13 per-role modifiers, now thin wrappers over ``LGTextStyle`` (so they scale with
// Dynamic Type too). Kept for source compatibility; use `.textStyle(.h1)` etc.

@available(*, deprecated, message: "Use .textStyle(.h1)")
public struct H1Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h1)) }
}
@available(*, deprecated, message: "Use .textStyle(.h2)")
public struct H2Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h2)) }
}
@available(*, deprecated, message: "Use .textStyle(.h3)")
public struct H3Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h3)) }
}
@available(*, deprecated, message: "Use .textStyle(.h4)")
public struct H4Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h4)) }
}
@available(*, deprecated, message: "Use .textStyle(.h5)")
public struct H5Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h5)) }
}
@available(*, deprecated, message: "Use .textStyle(.h6)")
public struct H6Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.h6)) }
}
@available(*, deprecated, message: "Use .textStyle(.subtitle1)")
public struct Subtitle1Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.subtitle1)) }
}
@available(*, deprecated, message: "Use .textStyle(.subtitle2)")
public struct Subtitle2Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.subtitle2)) }
}
@available(*, deprecated, message: "Use .textStyle(.body1)")
public struct Body1Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.body1)) }
}
@available(*, deprecated, message: "Use .textStyle(.body2)")
public struct Body2Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.body2)) }
}
@available(*, deprecated, message: "Use .textStyle(.caption)")
public struct CaptionStyle: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.caption)) }
}
@available(*, deprecated, message: "Use .textStyle(.caption2)")
public struct Caption2Style: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.caption2)) }
}
@available(*, deprecated, message: "Use .textStyle(.overline)")
public struct OverlineStyle: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View { content.modifier(LGTextStyle(.overline)) }
}
