//
//  RotateButtonView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 11/11/2025.
//

import SwiftUI

/// An icon button that spins a full turn when tapped — a refresh / sync affordance.
///
/// ```swift
/// RotateButtonView(imageStyle: .clockwiseRotated, width: theme.size.m, height: theme.size.m) {
///     viewModel.refresh()
/// }
/// ```
public struct RotateButtonView: View {

    /// The SF Symbols that read as "rotate / refresh". Use `imageName:` for an asset instead.
    public enum ImageStyle: String, Sendable, CaseIterable {
        /// Two arrows chasing each other inside a circle.
        case circlePath = "arrow.2.circlepath.circle"
        /// Same, filled.
        case circlePathFilled = "arrow.2.circlepath.circle.fill"
        /// Two arrows in a clockwise cycle.
        case clockwise = "arrow.trianglehead.2.clockwise"
        /// Same, rotated a quarter turn — the classic "refresh".
        case clockwiseRotated = "arrow.trianglehead.2.clockwise.rotate.90"
        /// Two arrows merging.
        case merge = "arrow.trianglehead.merge"
    }

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    /// Tint of the SF Symbol; `nil` uses the theme's text colour for the current colour scheme.
    public var color: Color?
    public var width: CGFloat
    public var height: CGFloat
    public var duration: Double
    public var ratio: Double
    let action: (() -> Void)?
    @State var rotationAngle: Double = 0
    var imageSystemName: String
    var imageName: String?

    public init(
        imageStyle: ImageStyle = .circlePath,
        imageName: String? = nil,
        color: Color? = nil,
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
                        .foregroundColor(color ?? theme.textColor(for: colorScheme))
                        .frame(width: width/ratio, height: height/ratio)
                        .rotationEffect(.degrees(rotationAngle))
                }
            }
            .frame(width: width, height: height)
        }
    }
}
