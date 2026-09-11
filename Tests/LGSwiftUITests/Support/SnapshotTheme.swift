//
//  SnapshotTheme.swift
//  LGSwiftUITests
//
//  A fully specified theme for snapshot tests. Every colour is set explicitly on both the
//  light and dark side so the snapshots lock the *styles'* behaviour (which side they
//  read, how they compose) independently of whatever the library's defaults are.
//  The dark side mirrors what the consuming apps (Pampuko, RemoteTV) actually ship.
//

import SwiftUI
import LGSwiftUI

struct SnapshotTheme: Theme {
    var lightPrimaryBackgroundColor: Color = Color(red: 240, green: 240, blue: 240)
    var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightSecondaryBackgroundColor: Color = Color(red: 225, green: 225, blue: 225)
    var darkSecondaryBackgroundColor: Color = Color(red: 45, green: 45, blue: 45)

    var lightTextColor: Color = .black
    var darkTextColor: Color = .white

    var lightPrimaryColor: Color = Color(red: 240, green: 240, blue: 240)
    var darkPrimaryColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightGradient1Color: Color = Color(red: 200, green: 200, blue: 200)
    var darkGradient1Color: Color = Color(red: 100, green: 100, blue: 100)
    var lightGradient2Color: Color = .white
    var darkGradient2Color: Color = .black
    var lightToggleColor: Color = .blue
    var darkToggleColor: Color = .orange
    var backgroundStatusColor: Color = Color(red: 30, green: 30, blue: 30)
    var initialStatusColor: Color = .orange
    var progressStatusColor: Color = .yellow
    var acceptedStatusColor: Color = .green
    var refusedStatusColor: Color = .red
}

extension View {
    /// Mirrors how both consuming apps inject the library: a theme in the environment,
    /// the primary background behind everything, and a forced colour scheme.
    func snapshotEnvironment(_ colorScheme: ColorScheme) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle(BackgroundPrimaryStyle())
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, colorScheme)
    }
}
