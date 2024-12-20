//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

///SmallMargin
public struct CaptionSmallMarginKey: EnvironmentKey {
    public static let defaultValue = 8.0
}

public extension EnvironmentValues {
    var smallMargin: CGFloat {
        get { self[CaptionSmallMarginKey.self] }
        set { self[CaptionSmallMarginKey.self] = newValue }
    }
}

///MediumMargin
public struct CaptionMediumMarginKey: EnvironmentKey {
    public static let defaultValue = 16.0
}

public extension EnvironmentValues {
    var mediumMargin: CGFloat {
        get { self[CaptionMediumMarginKey.self] }
        set { self[CaptionMediumMarginKey.self] = newValue }
    }
}

///LargeMargin
public struct CaptionLargeMarginKey: EnvironmentKey {
    public static let defaultValue = 24.0
}

public extension EnvironmentValues {
    var largeMargin: CGFloat {
        get { self[CaptionLargeMarginKey.self] }
        set { self[CaptionLargeMarginKey.self] = newValue }
    }
}

///VeryLargeMargin
public struct CaptionVeryLargeMarginKey: EnvironmentKey {
    public static let defaultValue = 32.0
}

public extension EnvironmentValues {
    var veryLargeMargin: CGFloat {
        get { self[CaptionVeryLargeMarginKey.self] }
        set { self[CaptionVeryLargeMarginKey.self] = newValue }
    }
}

//********************************************************

public struct CaptionSmallValueKey: EnvironmentKey {
    public static let defaultValue = 24.0
}

public extension EnvironmentValues {
    var smallValue: CGFloat {
        get { self[CaptionSmallValueKey.self] }
        set { self[CaptionSmallValueKey.self] = newValue }
    }
}

public struct CaptionMediumValueKey: EnvironmentKey {
    public static let defaultValue = 48.0
}

public extension EnvironmentValues {
    var mediumValue: CGFloat {
        get { self[CaptionMediumValueKey.self] }
        set { self[CaptionMediumValueKey.self] = newValue }
    }
}

public struct CaptionLargeValueKey: EnvironmentKey {
    public static let defaultValue = 80.0
}

public extension EnvironmentValues {
    var largeValue: CGFloat {
        get { self[CaptionLargeValueKey.self] }
        set { self[CaptionLargeValueKey.self] = newValue }
    }
}

public struct CaptionVeryLargeValueKey: EnvironmentKey {
    public static let defaultValue = 160.0
}

public extension EnvironmentValues {
    var veryLargeValue: CGFloat {
        get { self[CaptionVeryLargeValueKey.self] }
        set { self[CaptionVeryLargeValueKey.self] = newValue }
    }
}



