//
//  ExampleTheme.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

/// The light side is Pampuko's actual palette (the app's `MainTheme`): a mid-luminance
/// lavender-grey background that has enough headroom for both a dark drop shadow and a
/// light highlight to read clearly — which is exactly why it was picked here, after the
/// darker, near-black `dark*` colours (mirroring RemoteTV) turned out to wash the
/// neumorphic shapes out on the Neumorphism screen (fill ≈ background, only a faint glow
/// left). The gallery defaults to Light for that reason — see `DemoSettings`.
/// `Color(red:green:blue:)` is LGSwiftUI's 0-255 initializer.
struct ExampleTheme: Theme {
    var lightPrimaryBackgroundColor: Color = Color(red: 225, green: 225, blue: 235)
    var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightSecondaryBackgroundColor: Color = Color(red: 120, green: 179, blue: 241)
    var darkSecondaryBackgroundColor: Color = Color(red: 45, green: 45, blue: 45)

    var lightTextColor: Color = Color(red: 129, green: 128, blue: 152)
    var darkTextColor: Color = .white

    var lightPrimaryColor: Color = Color(red: 246, green: 180, blue: 2)
    var darkPrimaryColor: Color = Color(red: 30, green: 30, blue: 30)
    var lightGradient1Color: Color = Color(red: 73, green: 168, blue: 179)
    var darkGradient1Color: Color = Color(uiColor: .systemGray4)
    var lightGradient2Color: Color = .orange
    var darkGradient2Color: Color = .black
    var lightToggleColor: Color = .white
    var darkToggleColor: Color = .orange

    var backgroundStatusColor: Color = Color(red: 120, green: 179, blue: 241)
    var initialStatusColor: Color = .orange
    var progressStatusColor: Color = .yellow
    var acceptedStatusColor: Color = .green
    var refusedStatusColor: Color = .red
}
