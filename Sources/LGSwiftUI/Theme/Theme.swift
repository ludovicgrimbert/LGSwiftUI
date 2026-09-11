//
//  Theme.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 20/12/2024.
//

import SwiftUI

// MARK: - Token groups

/// Gaps between elements: padding, stack spacing, insets.
public struct ThemeSpacing: Sendable, Equatable {
    public var xs: CGFloat
    public var s: CGFloat
    public var m: CGFloat
    public var l: CGFloat
    public var xl: CGFloat

    public init(xs: CGFloat = 8, s: CGFloat = 16, m: CGFloat = 24, l: CGFloat = 32, xl: CGFloat = 48) {
        self.xs = xs
        self.s = s
        self.m = m
        self.l = l
        self.xl = xl
    }
}

/// Dimensions of elements: icon sizes, control heights, fixed widths.
///
/// Read `\.lgScaledSize` from the environment instead of `theme.size` when the element
/// should grow with the user's Dynamic Type setting (see ``ThemeSize/scaled(for:)``).
public struct ThemeSize: Sendable, Equatable {
    public var s: CGFloat
    public var m: CGFloat
    public var l: CGFloat
    public var xl: CGFloat

    public init(s: CGFloat = 24, m: CGFloat = 48, l: CGFloat = 80, xl: CGFloat = 160) {
        self.s = s
        self.m = m
        self.l = l
        self.xl = xl
    }
}

/// Corner radii.
public struct ThemeRadius: Sendable, Equatable {
    public var s: CGFloat
    public var m: CGFloat

    public init(s: CGFloat = 8, m: CGFloat = 24) {
        self.s = s
        self.m = m
    }
}

// MARK: - Theme

/// The design tokens a consuming app provides to the library.
///
/// Every requirement has a default, so an app only overrides what it needs:
///
/// ```swift
/// struct AppTheme: Theme {
///     var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30) // 0-255, see ExtColor.swift
///     var darkTextColor: Color = .white
///     var size = ThemeSize(l: 120)
/// }
/// ```
///
/// Colours come in `light*`/`dark*` pairs; every style in the library picks one side
/// based on the `colorScheme` in the environment. The defaults are the system's
/// semantic colours, which already adapt to the colour scheme, so a theme that
/// overrides only its `dark*` side (as apps forcing dark mode do) still renders a
/// sensible light mode.
///
/// Numeric tokens are grouped by what they are for — ``spacing`` (gaps), ``size``
/// (dimensions) and ``radius`` (corners). The flat `smallValue`/`smallMargin`/… tokens
/// are deprecated aliases of those groups and will be removed in 1.0.
public protocol Theme: Sendable {
    //    ************* BACKGROUND STYLE *************
    var lightPrimaryBackgroundColor: Color { get }
    var darkPrimaryBackgroundColor: Color { get }
    var lightSecondaryBackgroundColor: Color { get }
    var darkSecondaryBackgroundColor: Color { get }

    //    ************* TEXT STYLE *************
    var lightTextColor: Color { get }
    var darkTextColor: Color { get }

    //    ************* BUTTON STYLE *************
    var lightPrimaryColor: Color { get }
    var darkPrimaryColor: Color { get }
    var lightGradient1Color: Color { get }
    var darkGradient1Color: Color { get }
    var lightGradient2Color: Color { get }
    var darkGradient2Color: Color { get }
    var lightToggleColor: Color { get }
    var darkToggleColor: Color { get }
    var backgroundStatusColor: Color { get }
    var initialStatusColor: Color { get }
    var progressStatusColor: Color { get }
    var acceptedStatusColor: Color { get }
    var refusedStatusColor: Color { get }

    //    ************* LAYOUT TOKENS *************
    var spacing: ThemeSpacing { get }
    var size: ThemeSize { get }
    var radius: ThemeRadius { get }

    //    ************* LEGACY FLAT TOKENS (deprecated) *************
    @available(*, deprecated, message: "Use theme.size.s for a dimension, theme.spacing.m for a gap, or theme.radius.m for a corner")
    var smallValue: CGFloat { get }
    @available(*, deprecated, message: "Use theme.size.m for a dimension or theme.spacing.xl for a gap")
    var mediumValue: CGFloat { get }
    @available(*, deprecated, renamed: "size.l")
    var largeValue: CGFloat { get }
    @available(*, deprecated, renamed: "size.xl")
    var veryLargeValue: CGFloat { get }

    @available(*, deprecated, message: "Use theme.spacing.xs for a gap or theme.radius.s for a corner")
    var smallMargin: CGFloat { get }
    @available(*, deprecated, renamed: "spacing.s")
    var mediumMargin: CGFloat { get }
    @available(*, deprecated, renamed: "spacing.m")
    var largeMargin: CGFloat { get }
    @available(*, deprecated, renamed: "spacing.l")
    var veryLargeMargin: CGFloat { get }

    @available(*, deprecated, message: "Name a token after its role, not its value; use an explicit layout constant")
    var oneHundred: CGFloat { get }
    @available(*, deprecated, message: "Name a token after its role, not its value; use an explicit layout constant")
    var twoHundred: CGFloat { get }
}

public extension Theme {
    //    ************* BACKGROUND STYLE *************
    var lightPrimaryBackgroundColor: Color { Color(uiColor: .systemBackground) }
    var darkPrimaryBackgroundColor: Color { Color(uiColor: .systemBackground) }
    var lightSecondaryBackgroundColor: Color { Color(uiColor: .secondarySystemBackground) }
    var darkSecondaryBackgroundColor: Color { Color(uiColor: .secondarySystemBackground) }

    //    ************* TEXT STYLE *************
    var lightTextColor: Color { Color(uiColor: .label) }
    var darkTextColor: Color { Color(uiColor: .label) }

    //    ************* BUTTON STYLE *************
    var lightPrimaryColor: Color { Color(uiColor: .secondarySystemBackground) }
    var darkPrimaryColor: Color { Color(uiColor: .secondarySystemBackground) }
    var lightGradient1Color: Color { Color(uiColor: .systemGray4) }
    var darkGradient1Color: Color { Color(uiColor: .systemGray4) }
    var lightGradient2Color: Color { Color(uiColor: .systemGray) }
    var darkGradient2Color: Color { Color(uiColor: .systemGray) }
    var lightToggleColor: Color { .accentColor }
    var darkToggleColor: Color { .accentColor }
    var backgroundStatusColor: Color { Color(uiColor: .secondarySystemBackground) }
    var initialStatusColor: Color { .orange }
    var progressStatusColor: Color { .yellow }
    var acceptedStatusColor: Color { .green }
    var refusedStatusColor: Color { .red }

    //    ************* LAYOUT TOKENS *************
    var spacing: ThemeSpacing { ThemeSpacing() }
    var size: ThemeSize { ThemeSize() }
    var radius: ThemeRadius { ThemeRadius() }

    //    ************* LEGACY FLAT TOKENS *************
    // Derived from the groups so that an app overriding `size`/`spacing` keeps the old
    // names consistent while it migrates its call sites.
    var smallValue: CGFloat { size.s }
    var mediumValue: CGFloat { size.m }
    var largeValue: CGFloat { size.l }
    var veryLargeValue: CGFloat { size.xl }

    var smallMargin: CGFloat { spacing.xs }
    var mediumMargin: CGFloat { spacing.s }
    var largeMargin: CGFloat { spacing.m }
    var veryLargeMargin: CGFloat { spacing.l }

    var oneHundred: CGFloat { 100.0 }
    var twoHundred: CGFloat { 200.0 }
}

// MARK: - Environment

enum ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = DefaultTheme()
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

/// What a view sees when no theme was injected (previews, sheets that don't inherit
/// the environment…): the protocol defaults, i.e. the system's semantic colours.
struct DefaultTheme: Theme {}
