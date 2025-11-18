//
//  ScrollableContainerView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 05/11/2025.
//

import SwiftUI

public struct ScrollableContainerView<Content: View>: View {
    
    @ViewBuilder var content: (GeometryProxy) -> Content
    
    @State var contentSize: CGSize = .zero
    
    public init(@ViewBuilder content: @escaping (GeometryProxy) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { containerProxy in
            ScrollView {
                content(containerProxy)
                    .sizeAware(viewSize: $contentSize)
                    .frame(
                        minWidth: containerProxy.size.width,
                        minHeight: containerProxy.size.height
                        ,
                        alignment: .center
                    )
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(contentSize.height <= containerProxy.size.height)
            .frame(height: containerProxy.size.height)
        }
    }
}

struct SizeAwareModifier: ViewModifier {
    @Binding var viewSize: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            updateSizeIfNeeded(geometry.size)
                        }
                        .onChange(of: geometry.size) { oldSize, newSize in
                            updateSizeIfNeeded(newSize)
                        }
                }
            )
    }
    
    private func updateSizeIfNeeded(_ newSize: CGSize) {
        if viewSize != newSize {
            viewSize = newSize
        }
    }
}

extension View {
    func sizeAware(viewSize: Binding<CGSize>) -> some View {
        self.modifier(SizeAwareModifier(viewSize: viewSize))
    }
}
