//
//  ExtView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 16/11/2025.
//
import SwiftUI

public extension View {
    func overlayWithProxy(
        alignment: Alignment = .bottom,
        @ViewBuilder content: @escaping (GeometryProxy) -> some View
    ) -> some View {
        overlay(alignment: alignment) {
            GeometryReader { proxy in
                content(proxy)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: alignment
                    )
            }
        }
    }
}
