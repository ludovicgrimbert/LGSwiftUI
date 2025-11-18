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
    
    //    ************* VALUE *************
    var smallValue: CGFloat = 24.0
    var mediumValue: CGFloat  = 48.0
    var largeValue: CGFloat  = 80.0
    var veryLargeValue: CGFloat  = 160.0
    
    //    ************* MARGIN *************
    var smallMargin: CGFloat = 8.0
    var mediumMargin: CGFloat = 16.0
    var largeMargin: CGFloat = 24.0
    var veryLargeMargin: CGFloat = 32.0
}

