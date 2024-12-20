//
//  Theme.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 20/12/2024.
//

import SwiftUI

public protocol Theme: Sendable {
    var lightPrimaryBackgroundColor: Color { get set }
    var darkPrimaryBackgroundColor: Color { get set }
    
    var lightSecondaryBackgroundColor: Color { get set }
    var darkSecondaryBackgroundColor: Color { get set }
}

extension Theme {
    var lightPrimaryBackgroundColor: Color { Color.blue }
    var darkPrimaryBackgroundColor: Color { Color.blue }
    var lightSecondaryBackgroundColor: Color { Color.blue }
    var darkSecondaryBackgroundColor: Color { Color.blue }
}

enum ThemeKey: EnvironmentKey {
    static var defaultValue: Theme { DefaultTheme() }
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

struct DefaultTheme: Theme {
    var lightPrimaryBackgroundColor: Color = .red
    var darkPrimaryBackgroundColor: Color = .red
    var lightSecondaryBackgroundColor: Color = .red
    var darkSecondaryBackgroundColor: Color = .red
}

