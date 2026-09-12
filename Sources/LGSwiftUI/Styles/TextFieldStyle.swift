//
//  TextFieldStyle.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 08/01/2025.
//

import SwiftUI

/// Styles a `TextField`: text colour, optional fixed font, tint, default padding and an
/// optional rounded stroke. A plain view modifier: `TextFieldStyle` has no public
/// customisation point (only the private `_body`), so it is not used.
///
/// ```swift
/// TextField("Search", text: $query)
///     .lgTextFieldStyle(color: theme.darkTextColor, role: .caption)   // scales with Dynamic Type
/// ```
public struct LGTextFieldModifier: ViewModifier {
    var color: Color
    /// `nil` leaves the font untouched (used by the `role:` variant, which applies a scaled
    /// font before this modifier).
    var font: Font?
    var cornerRadius: CGFloat
    var strokeColor: Color
    var lineWidth: CGFloat

    public nonisolated init(color: Color,
                            font: Font?,
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
    /// Applies ``LGTextFieldModifier`` with a fixed font.
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

    /// Applies ``LGTextFieldModifier`` with a ``TextRole`` font that scales with Dynamic Type.
    func lgTextFieldStyle(color: Color,
                          role: TextRole,
                          cornerRadius: CGFloat = 0,
                          strokeColor: Color = .clear,
                          lineWidth: CGFloat = 1) -> some View {
        self
            .lgFont(role)
            .modifier(LGTextFieldModifier(color: color,
                                          font: nil,
                                          cornerRadius: cornerRadius,
                                          strokeColor: strokeColor,
                                          lineWidth: lineWidth))
    }
}
