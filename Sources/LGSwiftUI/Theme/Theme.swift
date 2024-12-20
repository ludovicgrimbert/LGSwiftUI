//
//  Theme.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 20/12/2024.
//

import SwiftUI

public protocol Theme: Sendable {
//    ************* BACKGROUND STYLE *************
    var lightPrimaryBackgroundColor: Color { get set }
    var darkPrimaryBackgroundColor: Color { get set }
    var lightSecondaryBackgroundColor: Color { get set }
    var darkSecondaryBackgroundColor: Color { get set }
    
    
}

extension Theme {
    //    ************* BACKGROUND STYLE *************
   // var lightPrimaryBackgroundColor: Color { Color.blue }
//    var darkPrimaryBackgroundColor: Color { Color.blue }
//    var lightSecondaryBackgroundColor: Color { Color.blue }
//    var darkSecondaryBackgroundColor: Color { Color.blue }
    
    var lightPrimaryBackgroundColor: Color { get{ return .green } set{} }
    var darkPrimaryBackgroundColor: Color { get{ return .green } set{} }
    var lightSecondaryBackgroundColor: Color { get{ return .green } set{} }
    var darkSecondaryBackgroundColor: Color { get{ return .green } set{} }

    
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
    
    
    
}

