//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 14/11/2021.
//

import SwiftUI

public extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
