//
//  File.swift
//  
//
//  Created by Ludovic Grimbert on 24/03/2024.
//

import SwiftUI

public extension View {
    func backgroundStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

public struct BackgroundPrimaryStyle: ViewModifier {
    public init() {}
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    
    public func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? theme.lightPrimaryBackgroundColor : theme.darkPrimaryBackgroundColor)
    }
}

public struct BackgroundSecondaryStyle: ViewModifier {
    public init() {}
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    
    public func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? theme.lightSecondaryBackgroundColor : theme.darkSecondaryBackgroundColor)
    }
}
