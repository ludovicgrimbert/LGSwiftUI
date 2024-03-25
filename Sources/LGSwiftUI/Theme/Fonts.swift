//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

/// Default Values
public struct CaptionFontH1Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 96,weight: .bold)
}
public struct CaptionFontH2Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 60,weight: .regular)
}
public struct CaptionFontH3Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 48,weight: .bold)
}
public struct CaptionFontH4Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 34,weight: .regular)
}
public struct CaptionFontH5Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 24,weight: .bold)
}
public struct CaptionFontH6Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 20,weight: .regular)
}
public struct CaptionFontSubtitle1Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 16,weight: .regular)
}
public struct CaptionFontSubtitle2Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 16,weight: .bold)
}
public struct CaptionFontBody1Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 14,weight: .regular)
}
public struct CaptionFontBody2Key: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 14,weight: .bold)
}
public struct CaptionFontCaptionKey: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 12,weight: .regular)
}
public struct CaptionFontOverlineKey: EnvironmentKey {
    public static let defaultValue =   Font.system(size: 10,weight: .regular)
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
    var h5: Font {
        get { self[CaptionFontH5Key.self] }
        set { self[CaptionFontH5Key.self] = newValue }
    }
    var h6: Font {
        get { self[CaptionFontH6Key.self] }
        set { self[CaptionFontH6Key.self] = newValue }
    }
    var subtitle1: Font {
        get { self[CaptionFontSubtitle1Key.self] }
        set { self[CaptionFontSubtitle1Key.self] = newValue }
    }
    var subtitle2: Font {
        get { self[CaptionFontSubtitle2Key.self] }
        set { self[CaptionFontSubtitle2Key.self] = newValue }
    }
    var body1: Font {
        get { self[CaptionFontBody1Key.self] }
        set { self[CaptionFontBody1Key.self] = newValue }
    }
    var body2: Font {
        get { self[CaptionFontBody2Key.self] }
        set { self[CaptionFontBody2Key.self] = newValue }
    }
    var caption: Font {
        get { self[CaptionFontCaptionKey.self] }
        set { self[CaptionFontCaptionKey.self] = newValue }
    }
    var overline: Font {
        get { self[CaptionFontOverlineKey.self] }
        set { self[CaptionFontOverlineKey.self] = newValue }
    }
}
