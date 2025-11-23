//
//  RotateButtonView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/11/2025.
//

import SwiftUI

public struct RotateButtonView: View {
    
    public enum ImageStyle: String {
        case style1 = "arrow.2.circlepath.circle"
        case style2 = "arrow.2.circlepath.circle.fill"
        case style3 = "arrow.trianglehead.2.clockwise"
        case style4 = "arrow.trianglehead.2.clockwise.rotate.90"
        case style5 = "arrow.trianglehead.merge"
    }
    
    public var color: Color
    public var width: CGFloat
    public var height: CGFloat
    public var duration: Double
    public var ratio: Double
    let action:  (() -> Void)?
    @State var rotationAngle: Double = 0
    var imageSystemName: String
    var imageName: String?


    public init(
        imageStyle: ImageStyle = .style1,
        imageName: String? = nil,
        color: Color = .blue,
        width: CGFloat,
        height: CGFloat,
        duration: Double = 2,
        ratio: Double = 1,
        action: (() -> Void)? = nil) {
            self.imageSystemName = imageStyle.rawValue
            self.imageName = imageName
            self.width = width
            self.height = height
            self.duration = duration
            self.ratio = ratio
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
            VStack {
                if let imageName = imageName {
                    Image(imageName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width/ratio, height: height/ratio)
                        .rotationEffect(.degrees(rotationAngle))
                } else {
                    Image(systemName: imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(color)
                        .frame(width: width/ratio, height: height/ratio)
                        .rotationEffect(.degrees(rotationAngle))
                }
            }
            .frame(width: width, height: height)
        }
    }
}
