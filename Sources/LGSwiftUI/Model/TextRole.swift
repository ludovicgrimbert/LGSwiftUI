//
//  TextRole.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// The typographic roles of the design system, with their base metrics. Rendered through
/// ``LGTextStyle`` (`.textStyle(.h5)`) or ``SwiftUI/View/lgFont(_:)``, the size scales with
/// Dynamic Type relative to `relativeTo`; at the default setting it is exactly `size`.
public enum TextRole: String, CaseIterable, Sendable {
    case h1, h2, h3, h4, h5, h6
    case subtitle1, subtitle2
    case body1, body2
    case caption, caption2
    case overline

    /// Point size at the default Dynamic Type setting.
    public var size: CGFloat {
        switch self {
        case .h1: 96
        case .h2: 60
        case .h3: 48
        case .h4: 34
        case .h5: 24
        case .h6: 20
        case .subtitle1, .subtitle2: 16
        case .body1, .body2: 14
        case .caption, .caption2: 12
        case .overline: 10
        }
    }

    public var weight: Font.Weight {
        switch self {
        case .h1, .h3, .h5, .subtitle2, .body2, .caption2: .bold
        case .h2, .h4, .h6, .subtitle1, .body1, .caption, .overline: .regular
        }
    }

    /// The system text style whose Dynamic Type curve this role follows.
    public var relativeTo: Font.TextStyle {
        switch self {
        case .h1, .h2, .h3, .h4: .largeTitle
        case .h5: .title2
        case .h6: .title3
        case .subtitle1, .subtitle2: .callout
        case .body1, .body2: .body
        case .caption, .caption2: .caption
        case .overline: .caption2
        }
    }

    /// The font at a given point size (already scaled or not).
    public func font(size: CGFloat) -> Font {
        .system(size: size, weight: weight)
    }

    /// The font at the base size. Does not scale with Dynamic Type; prefer `.lgFont(role)` /
    /// `.textStyle(role)`, which do.
    public var fixedFont: Font {
        font(size: size)
    }
}
