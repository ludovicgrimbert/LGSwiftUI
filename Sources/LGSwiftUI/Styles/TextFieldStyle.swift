//
//  TextFieldStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 08/01/2025.
//

import SwiftUI

/// Styles a `TextField`: text colour and font, tint, default padding and an optional
/// rounded stroke.
///
/// ```swift
/// TextField("Search", text: $query)
///     .lgTextFieldStyle(color: theme.darkTextColor, font: body1)
/// ```
public struct LGTextFieldModifier: ViewModifier {
    var color: Color
    var font: Font
    var cornerRadius: CGFloat
    var strokeColor: Color
    var lineWidth: CGFloat

    // `ViewModifier` is main-actor isolated; this initializer only stores values, so it
    // is safe to call from any context (e.g. the deprecated `CustomTextFieldStyle.init`).
    public nonisolated init(color: Color,
                            font: Font,
                            cornerRadius: CGFloat = 0,
                            strokeColor: Color = .clear,
                            lineWidth: CGFloat = 1) {
        self.color = color
        self.font = font
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }

    public func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(font)
            .tint(color)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}

public extension View {
    /// Applies ``LGTextFieldModifier``. Meant for `TextField`s; being a plain view
    /// modifier it does not rely on `TextFieldStyle`'s private `_body` extension point.
    func lgTextFieldStyle(color: Color,
                          font: Font,
                          cornerRadius: CGFloat = 0,
                          strokeColor: Color = .clear,
                          lineWidth: CGFloat = 1) -> some View {
        modifier(LGTextFieldModifier(color: color,
                                     font: font,
                                     cornerRadius: cornerRadius,
                                     strokeColor: strokeColor,
                                     lineWidth: lineWidth))
    }
}

/// Kept for source compatibility. `TextFieldStyle` has no public customisation point:
/// conforming to it requires implementing the underscored `_body(configuration:)`,
/// which is not API and may break with any SDK. Prefer `View.lgTextFieldStyle(...)`.
@available(*, deprecated, message: "Use .lgTextFieldStyle(color:font:cornerRadius:strokeColor:lineWidth:) instead")
public struct CustomTextFieldStyle: TextFieldStyle {
    var modifier: LGTextFieldModifier

    public init(color: Color,
                font: Font,
                cornerRadius: CGFloat = 0,
                strokeColor: Color = .clear,
                lineWidth: CGFloat = 1) {
        modifier = LGTextFieldModifier(color: color,
                                       font: font,
                                       cornerRadius: cornerRadius,
                                       strokeColor: strokeColor,
                                       lineWidth: lineWidth)
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration.modifier(modifier)
    }
}
