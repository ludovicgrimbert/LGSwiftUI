//
//  ExampleTheme.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

/// Both sides of every colour are set so the gallery is meaningful in light and dark mode.
/// The dark side mirrors what RemoteTV ships. `Color(red:green:blue:)` is LGSwiftUI's 0-255
/// initializer.
struct ExampleTheme: Theme {
    var lightPrimaryBackgroundColor: Color = Color(red: 236, green: 236, blue: 241)
    var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightSecondaryBackgroundColor: Color = Color(red: 120, green: 179, blue: 241)
    var darkSecondaryBackgroundColor: Color = Color(red: 45, green: 45, blue: 45)

    var lightTextColor: Color = Color(red: 60, green: 60, blue: 80)
    var darkTextColor: Color = .white

    var lightPrimaryColor: Color = Color(red: 236, green: 236, blue: 241)
    var darkPrimaryColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightGradient1Color: Color = Color(red: 73, green: 168, blue: 179)
    var darkGradient1Color: Color = Color(uiColor: .systemGray4)
    var lightGradient2Color: Color = .orange
    var darkGradient2Color: Color = .black
    var lightToggleColor: Color = .blue
    var darkToggleColor: Color = .orange

    var backgroundStatusColor: Color = Color(red: 30, green: 30, blue: 30)
    var initialStatusColor: Color = .orange
    var progressStatusColor: Color = .yellow
    var acceptedStatusColor: Color = .green
    var refusedStatusColor: Color = .red
}
