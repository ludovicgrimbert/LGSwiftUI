//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct H1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.h1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightPrimaryColor : darkPrimaryColor)
    }
}

public struct H2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.h2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightPrimaryColor : darkPrimaryColor)
    }
}

public struct H3Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.h3) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightPrimaryColor : darkPrimaryColor)
    }
}

public struct H4Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.h4) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightPrimaryColor : darkPrimaryColor)
    }
}
