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
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct H2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct H3Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h3) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct H4Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h4) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct H5Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h5) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct H6Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.h6) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct Subtitle1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.subtitle1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct Subtitle2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.subtitle2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct Body1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.body1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct Body2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.body2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct CaptionStyle: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.caption) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}

public struct OverlineStyle: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.overline) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? lightTextColor : darkTextColor)
    }
}


