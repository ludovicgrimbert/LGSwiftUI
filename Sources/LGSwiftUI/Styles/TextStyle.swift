//
//  SwiftUIView.swift
//
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

public struct H1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    
    @Environment(\.h1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct H2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.h2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct H3Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.h3) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct H4Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.h4) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct H5Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.h5) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct H6Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.h6) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct Subtitle1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.subtitle1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct Subtitle2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.subtitle2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct Body1Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.body1) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct Body2Style: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.body2) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct CaptionStyle: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.caption) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}

public struct OverlineStyle: ViewModifier {
    public init() {}
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.overline) var font
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
    }
}


