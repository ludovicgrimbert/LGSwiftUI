//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// Default Values
public struct CaptionLightPrimaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.red
}

public struct CaptionDarkPrimaryColorKey: EnvironmentKey {
    public static let defaultValue =   Color.red
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
