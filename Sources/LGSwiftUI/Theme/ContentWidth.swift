//
//  ContentWidth.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 12/09/2026.
//

import SwiftUI

/// Layout tokens that depend on the size class.
public struct ThemeLayout: Sendable, Equatable {
    /// Widest a screen's content gets in a regular horizontal size class (iPad, large
    /// iPhones in landscape); the content is centred beyond that. Compact stays edge to edge.
    public var maxContentWidth: CGFloat

    public init(maxContentWidth: CGFloat = 640) {
        self.maxContentWidth = maxContentWidth
    }
}

public extension View {
    /// Caps the content's width to `theme.layout.maxContentWidth` in a regular horizontal
    /// size class and centres it; does nothing in compact. Put it *inside* the background
    /// so the background still fills the screen — `lgPrimaryBackground()` after it.
    ///
    /// ```swift
    /// screen
    ///     .lgContentWidth()
    ///     .lgPrimaryBackground()
    /// ```
    func lgContentWidth() -> some View {
        modifier(LGContentWidthModifier())
    }
}

public struct LGContentWidthModifier: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    public nonisolated init() {}

    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: horizontalSizeClass == .regular ? theme.layout.maxContentWidth : nil)
            .frame(maxWidth: .infinity)
    }
}
