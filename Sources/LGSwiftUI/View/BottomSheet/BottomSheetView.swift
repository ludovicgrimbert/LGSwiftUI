//
//  BottomSheetView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 14/11/2025.
//

import SwiftUI

public struct BottomSheetView: View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.h5) var h5
    @Environment(\.caption) var caption

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

    private var textColor: Color {
        colorScheme == .light ? theme.lightTextColor : theme.darkTextColor
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: theme.smallValue) {
                if let imageName = imageName {
                    Image(imageName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: theme.mediumValue,
                            height: theme.mediumValue
                        )
                }
                Text(title)
                    .foregroundColor(textColor)
                    .font(h5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)

                Text(description)
                    .foregroundColor(textColor)
                    .font(caption)
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
