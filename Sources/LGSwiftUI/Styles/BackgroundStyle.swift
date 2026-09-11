//
//  BackgroundStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 24/03/2024.
//

import SwiftUI

/// The two background layers of the theme.
public enum BackgroundLevel: Sendable {
    case primary
    case secondary
}

public extension View {
    /// Paints the theme's background colour for `level` and the current colour scheme
    /// behind the view. See also `lgPrimaryBackground()` to fill the whole screen.
    func lgBackground(_ level: BackgroundLevel = .primary) -> some View {
        modifier(LGBackgroundModifier(level: level))
    }

    /// This is `View.modifier(_:)` under a name SwiftUI already uses
    /// (`backgroundStyle(_: ShapeStyle)`). Use `.lgBackground(_:)` or `.modifier(_:)`.
    @available(*, deprecated, message: "Use .lgBackground(.primary) / .lgBackground(.secondary), or .modifier(_:)")
    func backgroundStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

public struct LGBackgroundModifier: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    let level: BackgroundLevel

    public nonisolated init(level: BackgroundLevel) {
        self.level = level
    }

    public func body(content: Content) -> some View {
        content.background(color)
    }

    private var color: Color {
        switch (level, colorScheme) {
        case (.primary, .light): theme.lightPrimaryBackgroundColor
        case (.primary, _): theme.darkPrimaryBackgroundColor
        case (.secondary, .light): theme.lightSecondaryBackgroundColor
        case (.secondary, _): theme.darkSecondaryBackgroundColor
        }
    }
}

@available(*, deprecated, message: "Use .lgBackground(.primary)")
public struct BackgroundPrimaryStyle: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View {
        content.modifier(LGBackgroundModifier(level: .primary))
    }
}

@available(*, deprecated, message: "Use .lgBackground(.secondary)")
public struct BackgroundSecondaryStyle: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View {
        content.modifier(LGBackgroundModifier(level: .secondary))
    }
}
