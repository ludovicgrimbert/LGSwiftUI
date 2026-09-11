//
//  NeumorphicButtonStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/09/2026.
//

import SwiftUI

/// A text button on a neumorphic shape — the pattern previously hand-built as
/// `ZStack { NeumorphismView(...); Text(title) }` in `BottomSheetView` and in the apps.
///
/// Defaults follow the theme: rounded rectangle with `radius.m`, `lowShadow` effect,
/// `size.m` height (scaled with Dynamic Type), primary background colour, text colour and
/// the `h5` role.
///
/// ```swift
/// Button("Delete", action: delete)
///     .buttonStyle(NeumorphicButtonStyle(width: 240))
/// ```
public struct NeumorphicButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.lgScaledSize) private var size

    var style: NeumorphismStyle?
    var effect: NeumorphismEffect
    var width: CGFloat?
    var height: CGFloat?
    var role: TextRole

    /// - Parameters:
    ///   - style: shape of the button; defaults to `.roundedRectangle(cornerRadius: theme.radius.m)`.
    ///   - effect: neumorphic treatment; defaults to `.lowShadow`.
    ///   - width: fixed width; `nil` sizes to the label.
    ///   - height: fixed height; `nil` defaults to the scaled `theme.size.m`.
    ///   - role: label typography; defaults to `.h5`.
    public nonisolated init(style: NeumorphismStyle? = nil,
                            effect: NeumorphismEffect = .lowShadow,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            role: TextRole = .h5) {
        self.style = style
        self.effect = effect
        self.width = width
        self.height = height
        self.role = role
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(theme.textColor(for: colorScheme))
            .lgFont(role)
            .neumorphic(style ?? .roundedRectangle(cornerRadius: theme.radius.m),
                        effect: effect,
                        width: width,
                        height: height ?? size.m)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
