//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct CaptionMarginKey: EnvironmentKey {
    public static let defaultValue = 32.0
}

public extension EnvironmentValues {
    var margin: CGFloat {
        get { self[CaptionMarginKey.self] }
        set { self[CaptionMarginKey.self] = newValue }
    }
}

//********************************************************

public struct CaptionButtonHeightKey: EnvironmentKey {
    public static let defaultValue = 57.0
}

public extension EnvironmentValues {
    var buttonHeight: CGFloat {
        get { self[CaptionButtonHeightKey.self] }
        set { self[CaptionButtonHeightKey.self] = newValue }
    }
}
