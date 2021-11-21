//
//  SwiftUIView.swift
//  
//
//  Created by Ludovic Grimbert on 21/11/2021.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.lightPrimary) var lightPrimaryColor
    @Environment(\.darkPrimary) var darkPrimaryColor
    @Environment(\.margin) var margin
    @Environment(\.buttonHeight) var buttonHeight
    
    public init(maxWidth:CGFloat) {
        self.maxWidth = maxWidth
    }
    var maxWidth: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(Font.body.weight(.semibold))
            .frame(maxWidth: maxWidth, minHeight: buttonHeight, alignment: .center)
            .background((colorScheme == .light ? lightPrimaryColor : darkPrimaryColor).opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(RoundedRectangle(cornerRadius: buttonHeight/2))
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .padding(.leading, margin)
    }
}

