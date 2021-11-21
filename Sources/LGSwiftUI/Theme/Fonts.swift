//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// Default Values
public struct CaptionFontH1Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 20,weight: .bold)
}
public struct CaptionFontH2Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 20,weight: .bold)
}
public struct CaptionFontH3Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 20,weight: .bold)
}
public struct CaptionFontH4Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 20,weight: .bold)
}

public extension EnvironmentValues {
    var h1: Font {
        get { self[CaptionFontH1Key.self] }
        set { self[CaptionFontH1Key.self] = newValue }
    }
    var h2: Font {
        get { self[CaptionFontH2Key.self] }
        set { self[CaptionFontH2Key.self] = newValue }
    }
    var h3: Font {
        get { self[CaptionFontH3Key.self] }
        set { self[CaptionFontH3Key.self] = newValue }
    }
    var h4: Font {
        get { self[CaptionFontH4Key.self] }
        set { self[CaptionFontH4Key.self] = newValue }
    }
}
