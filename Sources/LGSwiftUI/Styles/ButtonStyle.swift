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
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat,
                textIsCenter: Bool = true ) {
        self.maxValue = maxValue
        self.textIsCenter = textIsCenter
    }
    var maxValue: CGFloat
    var textIsCenter: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor))
            .font(font)
            .frame(maxWidth: maxValue, maxHeight: theme.mediumValue, alignment: textIsCenter ? .center : .leading)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct ClearButtonStyle: ButtonStyle {
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
            .frame(maxWidth: maxValue, maxHeight: theme.mediumValue, alignment: .center)
            .background(Color.clear.opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}


public struct PrimaryButtonStyle: ButtonStyle {
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
            .frame(maxWidth: maxValue, maxHeight: theme.mediumValue, alignment: .center)
            .border((colorScheme == .light ? theme.lightTextColor : theme.darkTextColor), width: 0.5)
            .background((colorScheme == .light ? theme.lightPrimaryColor : theme.darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(RoundedRectangle(cornerRadius: theme.mediumValue/2))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

public struct RectangleButtonStyle: ButtonStyle {
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
            .frame(maxWidth: maxValue, maxHeight: theme.mediumValue, alignment: .center)
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

public struct CircleToggleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat, isToggle: Bool) {
        self.maxValue = maxValue
        self.isToggle = isToggle
    }
    var maxValue: CGFloat
    var isToggle: Bool
    
    
    public func makeBody(configuration: Configuration) -> some View {
        switch (isToggle, colorScheme) {
        case (true, .light):
            configuration.label
                .foregroundColor(theme.lightToggleColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.lightPrimaryColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case (false, .light):
            configuration.label
                .foregroundColor(theme.lightTextColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.lightPrimaryColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case (true, .dark):
            configuration.label
                .foregroundColor(theme.darkToggleColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.darkPrimaryColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case (false, .dark):
            configuration.label
                .foregroundColor(theme.darkTextColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.darkPrimaryColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        default:
            configuration.label
                .foregroundColor(theme.lightTextColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.lightPrimaryColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        }
    }
}

public struct CircleStatusButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.body1) var font
    
    public init(maxValue: CGFloat, status: ThemeStatus) {
        self.maxValue = maxValue
        self.status = status
    }
    var maxValue: CGFloat
    var status: ThemeStatus
    
    public func makeBody(configuration: Configuration) -> some View {
        switch status {
        case .initial:
            configuration.label
                .foregroundColor(theme.initialStatusColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.backgroundStatusColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case .progress:
            configuration.label
                .foregroundColor(theme.progressStatusColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.backgroundStatusColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case .accepted:
            configuration.label
                .foregroundColor(theme.acceptedStatusColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.backgroundStatusColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        case .refused:
            configuration.label
                .foregroundColor(theme.refusedStatusColor)
                .font(font)
                .frame(maxWidth: maxValue, maxHeight: maxValue, alignment: .center)
                .background(theme.backgroundStatusColor.opacity(configuration.isPressed ? 0.7 : 1))
                .clipShape(Circle())
                .overlay(
                    PrimaryGradient()
                )
                .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
        }
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

