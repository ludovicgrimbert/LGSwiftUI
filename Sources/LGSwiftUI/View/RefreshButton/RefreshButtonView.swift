//
//  RefreshButtonView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/11/2025.
//

import SwiftUI

public struct RefreshButtonView: View {
    
    public enum ImageStyle: String {
        case style1 = "arrow.2.circlepath.circle"
        case style2 = "arrow.2.circlepath.circle.fill"
        case style3 = "arrow.trianglehead.2.clockwise"
        case style4 = "arrow.trianglehead.2.clockwise.rotate.90"
    }
    
    public var color: Color
    public var width: CGFloat
    public var height: CGFloat
    public var duration: Double = 2
    let action:  (() -> Void)?
    @State var rotationAngle: Double = 0
    var imageSystemName: String

    public init(
        imageStyle: ImageStyle = .style1,
        color: Color = .blue,
        width: CGFloat,
        height: CGFloat,
        duration: Double = 2,
        action: (() -> Void)? = nil) {
            self.imageSystemName = imageStyle.rawValue
            self.width = width
            self.height = height
            self.duration = duration
            self.color = color
            self.action = action
        }
    
    public var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: duration)) {
                rotationAngle += 360
            }
            action?()
        }) {
            Image(systemName: imageSystemName)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: width, height: height)
                .rotationEffect(.degrees(rotationAngle))
        }
    }
}
