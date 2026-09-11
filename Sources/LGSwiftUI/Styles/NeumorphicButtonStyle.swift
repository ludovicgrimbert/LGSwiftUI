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
/// Defaults follow the theme: rounded rectangle with `smallValue` radius, `lowShadow`
/// effect, `mediumValue` height, primary background colour, text colour and `h5` font.
///
/// ```swift
/// Button("Delete", action: delete)
///     .buttonStyle(NeumorphicButtonStyle(width: 240))
/// ```
public struct NeumorphicButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.h5) private var h5

    var style: NeumorphismStyle?
    var effect: NeumorphismEffect
    var width: CGFloat?
    var height: CGFloat?
    var font: Font?

    /// - Parameters:
    ///   - style: shape of the button; defaults to `.roundedRectangle(cornerRadius: theme.smallValue)`.
    ///   - effect: neumorphic treatment; defaults to `.lowShadow`.
    ///   - width: fixed width; `nil` sizes to the label.
    ///   - height: fixed height; `nil` defaults to `theme.mediumValue`.
    ///   - font: label font; `nil` defaults to the environment's `h5`.
    public nonisolated init(style: NeumorphismStyle? = nil,
                            effect: NeumorphismEffect = .lowShadow,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            font: Font? = nil) {
        self.style = style
        self.effect = effect
        self.width = width
        self.height = height
        self.font = font
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(colorScheme == .light ? theme.lightTextColor : theme.darkTextColor)
            .font(font ?? h5)
            .neumorphic(style ?? .roundedRectangle(cornerRadius: theme.smallValue),
                        effect: effect,
                        width: width,
                        height: height ?? theme.mediumValue)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
