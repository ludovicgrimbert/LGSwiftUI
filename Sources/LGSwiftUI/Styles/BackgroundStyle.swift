//
//  File.swift
//  
//
//  Created by Ludovic Grimbert on 24/03/2024.
//

import SwiftUI

public struct BackgroundPrimaryStyle: ViewModifier {
    public init() {}
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
//    @Environment(\.lightPrimaryBackground) var lightPrimaryBackgroundColor
//    @Environment(\.darkPrimaryBackground) var darkPrimaryBackgroundColor
    
    public func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? theme.lightPrimaryBackgroundColor : theme.darkPrimaryBackgroundColor)
//            .background(colorScheme == .light ? lightPrimaryBackgroundColor : darkPrimaryBackgroundColor)

    }
}

public struct BackgroundSecondaryStyle: ViewModifier {
    public init() {}
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
//    @Environment(\.lightSecondaryBackground) var lightSecondaryBackgroundColor
//    @Environment(\.darkSecondaryBackground) var darkSecondaryBackgroundColor
    
    public func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? theme.lightSecondaryBackgroundColor : theme.darkSecondaryBackgroundColor)
//            .background(colorScheme == .light ? lightSecondaryBackgroundColor : darkSecondaryBackgroundColor)
    }
}
