//
//  SwiftUIView.swift
//
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// Extra1
public struct CaptionLightExtra1ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra1ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra1: Color {
        get { self[CaptionLightExtra1ColorKey.self] }
        set { self[CaptionDarkExtra1ColorKey.self] = newValue }
    }
    var darkExtra1: Color {
        get { self[CaptionLightExtra1ColorKey.self] }
        set { self[CaptionDarkExtra1ColorKey.self] = newValue }
    }
}

/// Extra2
public struct CaptionLightExtra2ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra2ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra2: Color {
        get { self[CaptionLightExtra2ColorKey.self] }
        set { self[CaptionDarkExtra2ColorKey.self] = newValue }
    }
    var darkExtra2: Color {
        get { self[CaptionLightExtra2ColorKey.self] }
        set { self[CaptionDarkExtra2ColorKey.self] = newValue }
    }
}

/// Extra3
public struct CaptionLightExtra3ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra3ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra3: Color {
        get { self[CaptionLightExtra3ColorKey.self] }
        set { self[CaptionDarkExtra3ColorKey.self] = newValue }
    }
    var darkExtra3: Color {
        get { self[CaptionLightExtra3ColorKey.self] }
        set { self[CaptionDarkExtra3ColorKey.self] = newValue }
    }
}

/// Extra4
public struct CaptionLightExtra4ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra4ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra4: Color {
        get { self[CaptionLightExtra4ColorKey.self] }
        set { self[CaptionDarkExtra4ColorKey.self] = newValue }
    }
    var darkExtra4: Color {
        get { self[CaptionLightExtra4ColorKey.self] }
        set { self[CaptionDarkExtra4ColorKey.self] = newValue }
    }
}

/// Extra5
public struct CaptionLightExtra5ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra5ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra5: Color {
        get { self[CaptionLightExtra5ColorKey.self] }
        set { self[CaptionDarkExtra5ColorKey.self] = newValue }
    }
    var darkExtra5: Color {
        get { self[CaptionLightExtra5ColorKey.self] }
        set { self[CaptionDarkExtra5ColorKey.self] = newValue }
    }
}

/// Extra6
public struct CaptionLightExtra6ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.black
}

public struct CaptionDarkExtra6ColorKey: EnvironmentKey {
    public static let defaultValue =   Color.white
}

public extension EnvironmentValues {
    var lightExtra6: Color {
        get { self[CaptionLightExtra6ColorKey.self] }
        set { self[CaptionDarkExtra6ColorKey.self] = newValue }
    }
    var darkExtra6: Color {
        get { self[CaptionLightExtra6ColorKey.self] }
        set { self[CaptionDarkExtra6ColorKey.self] = newValue }
    }
}

/*
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
 public static let defaultValue =   Color.red
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
 */
