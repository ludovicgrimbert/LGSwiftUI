//
//  TextStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

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
