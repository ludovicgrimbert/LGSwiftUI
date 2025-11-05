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
    @Environment(\.subtitle2) var subtitle2
    
    var height: CGFloat
    var title: String
    var description: String
    var actionTitle: String
    var action:  (() -> Void)?
    var cancelTitle: String?
    var cancel:  (() -> Void)?
    
    public init(
        height: CGFloat,
        title: String,
        description: String,
        actionTitle: String,
        action: (() -> Void)?,
        cancelTitle: String? = nil,
        cancel: (() -> Void)? = nil,
    ) {
        self.height = height
        self.title = title
        self.description = description
        self.actionTitle = actionTitle
        self.action = action
        self.cancelTitle = cancelTitle
        self.cancel = cancel
    }
    
    public var body: some View {
        GeometryReader { proxy in
                VStack (spacing: theme.smallValue){
                    Spacer().frame(height: theme.smallValue)
                    
                    Text(title)
                        .foregroundColor(theme.darkTextColor)
                        .font(h5)
                        .lineLimit(2)
                        .frame(width: proxy.size.width * 0.7)
                    
                    Text(description)
                        .foregroundColor(theme.darkTextColor)
                        .font(subtitle2)
                        .lineLimit(2)
                        .frame(width: proxy.size.width * 0.7)
                    
                    Button(action: {
                        action?()
                    }) {
                        NeuButtonView(
                            title: actionTitle,
                            width: proxy.size.width * 0.5
                        )
                    }
                    
                    if let cancelTitle = cancelTitle {
                        Button(action: {
                            cancel?()
                        }) {
                            NeuButtonView(
                                title: cancelTitle,
                                width: proxy.size.width * 0.5
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

