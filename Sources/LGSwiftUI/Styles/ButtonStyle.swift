//
//  ButtonStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

// All button styles read the theme and the colour scheme from the environment, use the
// `body1` role for their label, and take their height from `\.lgScaledSize` so they grow
// with Dynamic Type (identical to the fixed `theme.size.m` at the default setting).

/// Flat text button: label on the primary colour, `size.m` tall at most.
public struct SimpleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.lgScaledSize) var size

    public init(maxValue: CGFloat,
                textIsCenter: Bool = true ) {
        self.maxValue = maxValue
        self.textIsCenter = textIsCenter
    }
    var maxValue: CGFloat
    var textIsCenter: Bool

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(theme.textColor(for: colorScheme))
            .lgFont(.body1)
            .frame(maxWidth: maxValue, maxHeight: size.m, alignment: textIsCenter ? .center : .leading)
            .background(theme.primaryColor(for: colorScheme).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

/// Text button without background.
public struct ClearButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.lgScaledSize) var size

    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(theme.textColor(for: colorScheme))
            .lgFont(.body1)
            .frame(maxWidth: maxValue, maxHeight: size.m, alignment: .center)
            .background(Color.clear.opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

/// Capsule-clipped text button with a hairline border.
public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.lgScaledSize) var size

    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat

    public func makeBody(configuration: Configuration) -> some View {
        // `.border(_:width:)` strokes a plain rectangle, drawn *before* the
        // `.clipShape(RoundedRectangle)` below cuts the view down to a capsule — so the
        // rectangle's corners get chopped off instead of the stroke following the capsule,
        // leaving 4 disconnected border segments (2 short horizontal ones poking past the
        // capsule's silhouette, 2 barely-visible vertical slivers). Stroking the same shape
        // used to clip fixes it: the border then follows the capsule exactly.
        let shape = RoundedRectangle(cornerRadius: size.m / 2)
        return configuration.label
            .foregroundColor(theme.textColor(for: colorScheme))
            .lgFont(.body1)
            .frame(maxWidth: maxValue, maxHeight: size.m, alignment: .center)
            .background(theme.primaryColor(for: colorScheme).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(shape)
            .overlay(shape.stroke(theme.textColor(for: colorScheme), lineWidth: 0.5))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

/// Rectangular text button with a hairline border.
public struct RectangleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.lgScaledSize) var size

    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(theme.textColor(for: colorScheme))
            .lgFont(.body1)
            .frame(maxWidth: maxValue, maxHeight: size.m, alignment: .center)
            .border(theme.textColor(for: colorScheme), width: 0.5)
            .background(theme.primaryColor(for: colorScheme).opacity(configuration.isPressed ? 0.7 : 1))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

/// Round icon button on the primary colour with a gradient ring.
///
/// `maxValue` is the diameter at the default Dynamic Type setting; like the label inside
/// (`.lgFont(.body1)`), it scales with the user's text size so the icon never crowds the
/// circle at larger accessibility sizes.
public struct CircleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    public init(maxValue: CGFloat) {
        self.maxValue = maxValue
    }
    var maxValue: CGFloat

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .circleButtonBody(configuration: configuration,
                              maxValue: maxValue * dynamicTypeSize.lgScaleFactor,
                              foreground: theme.textColor(for: colorScheme),
                              background: theme.primaryColor(for: colorScheme))
    }
}

/// ``CircleButtonStyle`` whose label switches to the toggle colour when `isToggle` is on.
public struct CircleToggleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    public init(maxValue: CGFloat, isToggle: Bool) {
        self.maxValue = maxValue
        self.isToggle = isToggle
    }
    var maxValue: CGFloat
    var isToggle: Bool

    public func makeBody(configuration: Configuration) -> some View {
        let foreground = isToggle
            ? (colorScheme == .light ? theme.lightToggleColor : theme.darkToggleColor)
            : theme.textColor(for: colorScheme)
        configuration.label
            .circleButtonBody(configuration: configuration,
                              maxValue: maxValue * dynamicTypeSize.lgScaleFactor,
                              foreground: foreground,
                              background: theme.primaryColor(for: colorScheme))
    }
}

/// ``CircleButtonStyle`` on the status background, whose label colour reflects a ``ThemeStatus``.
public struct CircleStatusButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.theme) var theme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    public init(maxValue: CGFloat, status: ThemeStatus) {
        self.maxValue = maxValue
        self.status = status
    }
    var maxValue: CGFloat
    var status: ThemeStatus

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .circleButtonBody(configuration: configuration,
                              maxValue: maxValue * dynamicTypeSize.lgScaleFactor,
                              foreground: theme.statusColor(for: status),
                              background: theme.backgroundStatusColor)
    }
}

// MARK: - Shared pieces

extension Theme {
    func textColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? lightTextColor : darkTextColor
    }

    func primaryColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? lightPrimaryColor : darkPrimaryColor
    }

    func statusColor(for status: ThemeStatus) -> Color {
        switch status {
        case .initial: initialStatusColor
        case .progress: progressStatusColor
        case .accepted: acceptedStatusColor
        case .refused: refusedStatusColor
        }
    }
}

private extension View {
    /// The body shared by the three circle button styles: `body1` label, square frame,
    /// circular background dimmed while pressed, gradient ring, press scale.
    func circleButtonBody(configuration: ButtonStyleConfiguration,
                          maxValue: CGFloat,
                          foreground: Color,
                          background: Color) -> some View {
        self
            .foregroundColor(foreground)
            .lgFont(.body1)
            // `maxWidth`/`maxHeight` only *cap* each axis; each one still resolves from
            // whatever that axis is independently proposed (by the icon's own content size
            // and the ambient layout), so nothing guarantees the two end up equal. Depending
            // on where the button sits (a NavigationStack destination with sibling sections
            // reproduced it; an isolated HStack didn't), that mismatch clips Circle()/Capsule()
            // into a flattened pill instead of a circle. An exact width/height always resolves
            // to precisely maxValue × maxValue, so the shape can't degenerate that way.
            .frame(width: maxValue, height: maxValue, alignment: .center)
            .background(background.opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(Circle())
            .overlay(PrimaryGradient())
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

/// The hairline gradient ring around circle buttons, from the theme's gradient pair for
/// the current colour scheme.
struct PrimaryGradient: View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Capsule()
            .stroke(
                LinearGradient(
                    gradient: Gradient(
                        colors: colorScheme == .light
                            ? [theme.lightGradient1Color, theme.lightGradient2Color]
                            : [theme.darkGradient1Color, theme.darkGradient2Color]
                    ),
                    startPoint: .top,
                    endPoint: .trailing
                ),
                lineWidth: 1.0
            )
    }
}
