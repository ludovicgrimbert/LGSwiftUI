//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct SimpleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? lightTextColor : darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
    }
}


public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? lightTextColor : darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .background((colorScheme == .light ? lightPrimaryColor : darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(RoundedRectangle(cornerRadius: mediumValue/2))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct RectangleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.mediumValue) var mediumValue
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? lightTextColor : darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: mediumValue, alignment: .center)
            .border((colorScheme == .light ? lightTextColor : darkTextColor), width: 0.5)
            .background((colorScheme == .light ? lightPrimaryColor : darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}




// REMOTE TV
public struct CircleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.lightText) var lightTextColor
    @Environment(\.darkText) var darkTextColor
    @Environment(\.body1) var font
    
    
    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? lightTextColor : darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
            .background((colorScheme == .light ? lightPrimaryColor : darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(Circle())
            .overlay(
                PrimaryGradient()
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct PrimaryGradient: View {
    
    @Environment(\.lightAccent) var lightAccentColor
    @Environment(\.darkAccent) var darkAccentColor

    var body: some View {
        Capsule()
            .stroke(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            lightAccentColor,
                            darkAccentColor
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .trailing
                ),
                lineWidth: 1.0
            )
    }
}

