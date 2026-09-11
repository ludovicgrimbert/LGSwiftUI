//
//  ThemeModifiers.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/09/2026.
//

import SwiftUI

public extension View {
    /// Injects a theme for every LGSwiftUI style below this view, optionally forcing the
    /// colour scheme they read.
    ///
    /// ```swift
    /// RootView()
    ///     .lgTheme(AppTheme(), colorScheme: .dark)
    /// ```
    ///
    /// - Parameters:
    ///   - theme: the app's `Theme`.
    ///   - colorScheme: when non-nil, sets `\.colorScheme` in the environment so the
    ///     library's styles pick that side of the theme. This only affects SwiftUI views
    ///     in this hierarchy — system UI (alerts, keyboard, sheets' chrome) keeps following
    ///     the device. Use `.preferredColorScheme(_:)` at the scene root instead if you
    ///     want the whole scene, system UI included, to switch.
    ///
    /// - Important: `\.theme` is inherited by presented sheets, but a forced `colorScheme`
    ///   is **not** — a `.sheet`/`.fullScreenCover` is a new presentation context that
    ///   starts from the system colour scheme. Apply `lgTheme(_:colorScheme:)` (typically
    ///   through your app's screen modifier) to the content of every sheet as well, or use
    ///   `.preferredColorScheme(_:)`.
    func lgTheme(_ theme: Theme, colorScheme: ColorScheme? = nil) -> some View {
        modifier(LGThemeModifier(theme: theme, colorScheme: colorScheme))
    }

    /// Expands to fill the available space and paints the theme's primary background
    /// behind the content — the usual screen root in an LGSwiftUI app.
    func lgPrimaryBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .lgBackground(.primary)
    }
}

struct LGThemeModifier: ViewModifier {
    let theme: Theme
    let colorScheme: ColorScheme?

    func body(content: Content) -> some View {
        content
            .transformEnvironment(\.colorScheme) { scheme in
                if let colorScheme { scheme = colorScheme }
            }
            .environment(\.theme, theme)
    }
}
