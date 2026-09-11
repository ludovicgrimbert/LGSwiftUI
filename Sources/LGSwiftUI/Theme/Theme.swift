//
//  Theme.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 20/12/2024.
//

import SwiftUI

/// The design tokens a consuming app provides to the library.
///
/// Every requirement has a default, so an app only overrides what it needs:
///
/// ```swift
/// struct AppTheme: Theme {
///     var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30) // 0-255, see ExtColor.swift
///     var darkTextColor: Color = .white
/// }
/// ```
///
/// Colours come in `light*`/`dark*` pairs; every style in the library picks one side
/// based on the `colorScheme` in the environment. The defaults are the system's
/// semantic colours, which already adapt to the colour scheme, so a theme that
/// overrides only its `dark*` side (as apps forcing dark mode do) still renders a
/// sensible light mode.
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

    //    ************* VALUE *************
    var smallValue: CGFloat { get }
    var mediumValue: CGFloat { get }
    var largeValue: CGFloat { get }
    var veryLargeValue: CGFloat { get }

    //    ************* MARGIN *************
    var smallMargin: CGFloat { get }
    var mediumMargin: CGFloat { get }
    var largeMargin: CGFloat { get }
    var veryLargeMargin: CGFloat { get }

    //    ************* HUNDRED *************
    var oneHundred: CGFloat { get }
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

    //    ************* VALUE *************
    var smallValue: CGFloat { 24.0 }
    var mediumValue: CGFloat { 48.0 }
    var largeValue: CGFloat { 80.0 }
    var veryLargeValue: CGFloat { 160.0 }

    //    ************* MARGIN *************
    var smallMargin: CGFloat { 8.0 }
    var mediumMargin: CGFloat { 16.0 }
    var largeMargin: CGFloat { 24.0 }
    var veryLargeMargin: CGFloat { 32.0 }

    //    ************* HUNDRED *************
    var oneHundred: CGFloat { 100.0 }
    var twoHundred: CGFloat { 200.0 }
}

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
