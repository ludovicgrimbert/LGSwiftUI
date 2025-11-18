//
//  LoaderView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 10/11/2025.
//
import SwiftUI

public struct LoaderView: View {

    public var tint: Color
    public init(tint: Color) {
        self.tint = tint
    }
   public var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tint))
            .scaleEffect(1.5)
    }
}
