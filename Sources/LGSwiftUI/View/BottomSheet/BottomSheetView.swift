//
//  BottomSheetView.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 14/11/2025.
//

import SwiftUI

public struct BottomSheetView: View {
    @Environment(\.theme) var theme
    @Environment(\.h5) var h5
    @Environment(\.caption) var caption
    
    var title: String
    var imageName: String?
    var description: String
    var actionTitle: String
    var action:  (() -> Void)?
    var cancelTitle: String?
    var cancel:  (() -> Void)?
    
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
                VStack (spacing: theme.smallValue) {
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
                        .foregroundColor(theme.darkTextColor)
                        .font(h5)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity)
                    
                    Text(description)
                        .foregroundColor(theme.darkTextColor)
                        .font(caption)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        action?()
                    }) {
                        NeuButtonView(
                            title: actionTitle,
                            width: proxy.size.width * 0.7
                        )
                    }
                    
                    if let cancelTitle = cancelTitle {
                        Button(action: {
                            cancel?()
                        }) {
                            NeuButtonView(
                                title: cancelTitle,
                                width: proxy.size.width * 0.7
                            )
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.darkPrimaryBackgroundColor)
        }
    }
    
    func NeuButtonView(
        title: String,
        width: CGFloat
    ) -> some View {
        ZStack {
            NeumorphismView(style: .roundedRectangle(cornerRadius: theme.smallValue),
                            level: .low,
                            type: .shadow,
                            width: width,
                            height: theme.mediumValue,
                            color: theme.darkPrimaryBackgroundColor)
            
            Text(title)
                .foregroundColor(theme.darkTextColor)
                .font(h5)
        }
    }
}


