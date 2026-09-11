//
//  LGSwiftUIExampleApp.swift
//  LGSwiftUIExample
//
//  A gallery of every LGSwiftUI style and component, rendered with the library's own API
//  (nothing deprecated). Use the toolbar to switch colour scheme and Dynamic Type size and
//  watch the tokens, text roles and controls follow.
//

import SwiftUI
import LGSwiftUI

@main
struct LGSwiftUIExampleApp: App {
    @State private var settings = DemoSettings()

    var body: some Scene {
        WindowGroup {
            GalleryView()
                .environment(settings)
                .lgTheme(ExampleTheme())
                // `preferredColorScheme` (rather than `lgTheme(colorScheme:)`) so that system UI
                // and presented sheets follow the choice too — see the README.
                .preferredColorScheme(settings.colorScheme)
                .dynamicTypeSize(settings.dynamicTypeSize)
        }
    }
}

/// Demo-wide knobs driven from the gallery toolbar.
@Observable
@MainActor
final class DemoSettings {
    /// `nil` follows the device.
    var colorScheme: ColorScheme?
    var dynamicTypeSize: DynamicTypeSize = .large
}

extension DynamicTypeSize {
    static let demoChoices: [DynamicTypeSize] = [.xSmall, .large, .xxxLarge, .accessibility3]

    var demoLabel: String {
        switch self {
        case .xSmall: "Extra small"
        case .large: "Default"
        case .xxxLarge: "XXX large"
        case .accessibility3: "Accessibility 3"
        default: String(describing: self)
        }
    }
}
