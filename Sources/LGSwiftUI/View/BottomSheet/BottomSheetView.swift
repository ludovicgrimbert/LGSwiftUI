//
//  BottomSheetView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 14/11/2025.
//

import SwiftUI

public struct BottomSheetView: View {
    @Environment(\.theme) var theme
    @Environment(\.lgScaledSize) var size

    var title: String
    var imageName: String?
    var description: String
    var actionTitle: String
    var action: (() -> Void)?
    var cancelTitle: String?
    var cancel: (() -> Void)?

    public init(
        title: String,
        imageName: String? = nil,
        description: String,
        actionTitle: String,
        action: (() -> Void)?,
        cancelTitle: String? = nil,
        cancel: (() -> Void)? = nil,
    ) {
        self.title = title
        self.imageName = imageName
        self.description = description
        self.actionTitle = actionTitle
        self.action = action
        self.cancelTitle = cancelTitle
        self.cancel = cancel
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: theme.spacing.m) {
                if let imageName = imageName {
                    Image(imageName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.m, height: size.m)
                }
                Text(title)
                    .textStyle(.h5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)

                Text(description)
                    .textStyle(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)

                Button(actionTitle) {
                    action?()
                }
                .buttonStyle(NeumorphicButtonStyle(width: proxy.size.width * 0.7))

                if let cancelTitle = cancelTitle {
                    Button(cancelTitle) {
                        cancel?()
                    }
                    .buttonStyle(NeumorphicButtonStyle(width: proxy.size.width * 0.7))
                }
            }
            .lgPrimaryBackground()
        }
    }
}
