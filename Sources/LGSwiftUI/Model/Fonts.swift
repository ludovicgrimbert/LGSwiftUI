//
//  Fonts.swift
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

    /// The fixed-size font, as the deprecated environment keys used to provide it.
    /// Does not scale with Dynamic Type; prefer `.lgFont(role)` / `.textStyle(role)`.
    public var fixedFont: Font {
        font(size: size)
    }
}

// MARK: - Deprecated environment fonts

// These keys hand out fixed-size fonts and were the only way to reach a role's font.
// They are kept, unchanged, for source compatibility; no consuming app overrides them.

@available(*, deprecated, message: "Use TextRole.h1 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH1Key: EnvironmentKey {
    public static let defaultValue = TextRole.h1.fixedFont
}
@available(*, deprecated, message: "Use TextRole.h2 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH2Key: EnvironmentKey {
    public static let defaultValue = TextRole.h2.fixedFont
}
@available(*, deprecated, message: "Use TextRole.h3 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH3Key: EnvironmentKey {
    public static let defaultValue = TextRole.h3.fixedFont
}
@available(*, deprecated, message: "Use TextRole.h4 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH4Key: EnvironmentKey {
    public static let defaultValue = TextRole.h4.fixedFont
}
@available(*, deprecated, message: "Use TextRole.h5 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH5Key: EnvironmentKey {
    public static let defaultValue = TextRole.h5.fixedFont
}
@available(*, deprecated, message: "Use TextRole.h6 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontH6Key: EnvironmentKey {
    public static let defaultValue = TextRole.h6.fixedFont
}
@available(*, deprecated, message: "Use TextRole.subtitle1 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontSubtitle1Key: EnvironmentKey {
    public static let defaultValue = TextRole.subtitle1.fixedFont
}
@available(*, deprecated, message: "Use TextRole.subtitle2 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontSubtitle2Key: EnvironmentKey {
    public static let defaultValue = TextRole.subtitle2.fixedFont
}
@available(*, deprecated, message: "Use TextRole.body1 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontBody1Key: EnvironmentKey {
    public static let defaultValue = TextRole.body1.fixedFont
}
@available(*, deprecated, message: "Use TextRole.body2 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontBody2Key: EnvironmentKey {
    public static let defaultValue = TextRole.body2.fixedFont
}
@available(*, deprecated, message: "Use TextRole.caption with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontCaptionKey: EnvironmentKey {
    public static let defaultValue = TextRole.caption.fixedFont
}
@available(*, deprecated, message: "Use TextRole.caption2 with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontCaption2Key: EnvironmentKey {
    public static let defaultValue = TextRole.caption2.fixedFont
}
@available(*, deprecated, message: "Use TextRole.overline with .textStyle(_:) or .lgFont(_:)")
public struct CaptionFontOverlineKey: EnvironmentKey {
    public static let defaultValue = TextRole.overline.fixedFont
}

public extension EnvironmentValues {
    @available(*, deprecated, message: "Use .textStyle(.h1) or .lgFont(.h1); environment fonts do not scale with Dynamic Type")
    var h1: Font {
        get { self[CaptionFontH1Key.self] }
        set { self[CaptionFontH1Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.h2) or .lgFont(.h2); environment fonts do not scale with Dynamic Type")
    var h2: Font {
        get { self[CaptionFontH2Key.self] }
        set { self[CaptionFontH2Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.h3) or .lgFont(.h3); environment fonts do not scale with Dynamic Type")
    var h3: Font {
        get { self[CaptionFontH3Key.self] }
        set { self[CaptionFontH3Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.h4) or .lgFont(.h4); environment fonts do not scale with Dynamic Type")
    var h4: Font {
        get { self[CaptionFontH4Key.self] }
        set { self[CaptionFontH4Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.h5) or .lgFont(.h5); environment fonts do not scale with Dynamic Type")
    var h5: Font {
        get { self[CaptionFontH5Key.self] }
        set { self[CaptionFontH5Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.h6) or .lgFont(.h6); environment fonts do not scale with Dynamic Type")
    var h6: Font {
        get { self[CaptionFontH6Key.self] }
        set { self[CaptionFontH6Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.subtitle1) or .lgFont(.subtitle1); environment fonts do not scale with Dynamic Type")
    var subtitle1: Font {
        get { self[CaptionFontSubtitle1Key.self] }
        set { self[CaptionFontSubtitle1Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.subtitle2) or .lgFont(.subtitle2); environment fonts do not scale with Dynamic Type")
    var subtitle2: Font {
        get { self[CaptionFontSubtitle2Key.self] }
        set { self[CaptionFontSubtitle2Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.body1) or .lgFont(.body1); environment fonts do not scale with Dynamic Type")
    var body1: Font {
        get { self[CaptionFontBody1Key.self] }
        set { self[CaptionFontBody1Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.body2) or .lgFont(.body2); environment fonts do not scale with Dynamic Type")
    var body2: Font {
        get { self[CaptionFontBody2Key.self] }
        set { self[CaptionFontBody2Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.caption) or .lgFont(.caption); environment fonts do not scale with Dynamic Type")
    var caption: Font {
        get { self[CaptionFontCaptionKey.self] }
        set { self[CaptionFontCaptionKey.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.caption2) or .lgFont(.caption2); environment fonts do not scale with Dynamic Type")
    var caption2: Font {
        get { self[CaptionFontCaption2Key.self] }
        set { self[CaptionFontCaption2Key.self] = newValue }
    }
    @available(*, deprecated, message: "Use .textStyle(.overline) or .lgFont(.overline); environment fonts do not scale with Dynamic Type")
    var overline: Font {
        get { self[CaptionFontOverlineKey.self] }
        set { self[CaptionFontOverlineKey.self] = newValue }
    }
}
