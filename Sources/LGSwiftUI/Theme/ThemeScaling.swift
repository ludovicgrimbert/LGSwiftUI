//
//  ThemeScaling.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/09/2026.
//

import SwiftUI

public extension DynamicTypeSize {
    /// The point size of the `.body` text style at this setting, from Apple's Dynamic Type
    /// tables. `.large` (the default) is 17.
    var bodyPointSize: CGFloat {
        switch self {
        case .xSmall: 14
        case .small: 15
        case .medium: 16
        case .large: 17
        case .xLarge: 19
        case .xxLarge: 21
        case .xxxLarge: 23
        case .accessibility1: 28
        case .accessibility2: 33
        case .accessibility3: 40
        case .accessibility4: 47
        case .accessibility5: 53
        @unknown default: 17
        }
    }

    /// How much a `.body`-relative metric grows at this setting: `1` at `.large`.
    var lgScaleFactor: CGFloat {
        bodyPointSize / DynamicTypeSize.large.bodyPointSize
    }
}

public extension ThemeSize {
    /// The sizes multiplied by the Dynamic Type factor — exactly what `@ScaledMetric(relativeTo: .body)`
    /// does, so a control sized with these grows in step with its `.body`-relative text.
    /// Returns `self` unchanged at the default `.large` setting.
    func scaled(for dynamicTypeSize: DynamicTypeSize) -> ThemeSize {
        let factor = dynamicTypeSize.lgScaleFactor
        return ThemeSize(xxs: xxs * factor, xs: xs * factor, s: s * factor, m: m * factor, l: l * factor, xl: xl * factor)
    }
}

public extension EnvironmentValues {
    /// `theme.size` scaled by the current `dynamicTypeSize`. Use it for dimensions that
    /// wrap text (control heights, icon sizes, touch targets) so they grow with the user's
    /// text setting instead of truncating it:
    ///
    /// ```swift
    /// @Environment(\.lgScaledSize) private var size
    /// …
    /// .frame(minHeight: size.m)
    /// ```
    var lgScaledSize: ThemeSize {
        theme.size.scaled(for: dynamicTypeSize)
    }
}
