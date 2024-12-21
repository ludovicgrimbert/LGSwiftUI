//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct SimpleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct ClearButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .background(Color.clear.opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}


public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .border((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor), width: 0.5)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(RoundedRectangle(cornerRadius: mediumValue/2))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct RectangleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .border((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor), width: 0.5)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct CircleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.body1) var font
    
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(Circle())
            .overlay(
                PrimaryGradient()
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct PrimaryGradient: View {
    @Environment(\.theme) var theme

    var body: some View {
        Capsule()
            .stroke(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            theme.darkGradient1Color,
                            theme.darkGradient2Color
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .trailing
                ),
                lineWidth: 1.0
            )
    }
}

