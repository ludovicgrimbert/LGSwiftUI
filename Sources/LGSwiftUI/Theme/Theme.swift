//
//  Theme.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 20/12/2024.
//

import SwiftUI

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
    
}

public extension Theme {
    //    ************* BACKGROUND STYLE *************
    var lightPrimaryBackgroundColor: Color { Color.green }
    var darkPrimaryBackgroundColor: Color { Color.green }
    var lightSecondaryBackgroundColor: Color { Color.green }
    var darkSecondaryBackgroundColor: Color { Color.green }
    
    //    ************* TEXT STYLE *************
    var lightTextColor: Color { Color.green }
    var darkTextColor: Color { Color.green }
    
    //    ************* BUTTON STYLE *************
    var lightPrimaryColor: Color { Color.green }
    var darkPrimaryColor: Color { Color.green }
    var lightGradient1Color: Color { Color.green }
    var darkGradient1Color: Color { Color.green }
    var lightGradient2Color: Color { Color.green }
    var darkGradient2Color: Color { Color.green }
    var lightToggleColor: Color { Color.green }
    var darkToggleColor: Color { Color.green }
    var backgroundStatusColor: Color { Color.green }
    var initialStatusColor: Color { Color.green }
    var progressStatusColor: Color { Color.green }
    var acceptedStatusColor: Color { Color.green }
    var refusedStatusColor: Color { Color.green }
    
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
    //    ************* BACKGROUND STYLE *************
    var lightPrimaryBackgroundColor: Color = .green
    var darkPrimaryBackgroundColor: Color = .green
    var lightSecondaryBackgroundColor: Color = .green
    var darkSecondaryBackgroundColor: Color = .green
    
    //    ************* TEXT STYLE *************
    var lightTextColor: Color = .green
    var darkTextColor: Color = .green
    
    //    ************* BUTTON STYLE *************
    var lightPrimaryColor: Color = .green
    var darkPrimaryColor: Color = .green
    var lightGradient1Color: Color = .green
    var darkGradient1Color: Color = .green
    var lightGradient2Color: Color = .green
    var darkGradient2Color: Color = .green
    var lightToggleColor: Color = .green
    var darkToggleColor: Color = .green
    var backgroundStatusColor: Color = .green
    var initialStatusColor: Color = .green
    var progressStatusColor: Color = .green
    var acceptedStatusColor: Color = .green
    var refusedStatusColor: Color = .green
}

