//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// Text
public struct CaptionLightTextColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkTextColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightText: Color {
        get { self[CaptionLightTextColorKey.self] }
        set { self[CaptionLightTextColorKey.self] = newValue }
    }
    var darkText: Color {
        get { self[CaptionDarkTextColorKey.self] }
        set { self[CaptionDarkTextColorKey.self] = newValue }
    }
}

/// Primary
public struct CaptionLightPrimaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.blue
}

public struct CaptionDarkPrimaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.yellow
}

public extension EnvironmentValues {
    var lightPrimary: Color {
        get { self[CaptionLightPrimaryColorKey.self] }
        set { self[CaptionLightPrimaryColorKey.self] = newValue }
    }
    var darkPrimary: Color {
        get { self[CaptionDarkPrimaryColorKey.self] }
        set { self[CaptionDarkPrimaryColorKey.self] = newValue }
    }
}

/// Secondary
public struct CaptionLightSecondaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.gray
}

public struct CaptionDarkSecondaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightSecondary: Color {
        get { self[CaptionLightSecondaryColorKey.self] }
        set { self[CaptionLightSecondaryColorKey.self] = newValue }
    }
    var darkSecondary: Color {
        get { self[CaptionDarkSecondaryColorKey.self] }
        set { self[CaptionDarkSecondaryColorKey.self] = newValue }
    }
}

/// Accent
public struct CaptionLightAccentColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public struct CaptionDarkAccentColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public extension EnvironmentValues {
    var lightAccent: Color {
        get { self[CaptionLightAccentColorKey.self] }
        set { self[CaptionLightAccentColorKey.self] = newValue }
    }
    var darkAccent: Color {
        get { self[CaptionDarkAccentColorKey.self] }
        set { self[CaptionDarkAccentColorKey.self] = newValue }
    }
}

/// Background
/// Primary

public struct CaptionLightPrimaryBackgroundColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public struct CaptionDarkPrimaryBackgroundColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public extension EnvironmentValues {
    var lightPrimaryBackground: Color {
        get { self[CaptionLightPrimaryBackgroundColorKey.self] }
        set { self[CaptionLightPrimaryBackgroundColorKey.self] = newValue }
    }
    var darkPrimaryBackground: Color {
        get { self[CaptionDarkPrimaryBackgroundColorKey.self] }
        set { self[CaptionDarkPrimaryBackgroundColorKey.self] = newValue }
    }
}

/// Secondary

public struct CaptionLightSecondaryBackgroundColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public struct CaptionDarkSecondaryBackgroundColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public extension EnvironmentValues {
    var lightSecondaryBackground: Color {
        get { self[CaptionLightSecondaryBackgroundColorKey.self] }
        set { self[CaptionLightSecondaryBackgroundColorKey.self] = newValue }
    }
    var darkSecondaryBackground: Color {
        get { self[CaptionDarkSecondaryBackgroundColorKey.self] }
        set { self[CaptionDarkSecondaryBackgroundColorKey.self] = newValue }
    }
}
