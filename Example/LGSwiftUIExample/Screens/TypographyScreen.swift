//
//  TypographyScreen.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct TypographyScreen: View {
    @Environment(\.theme) private var theme

    var body: some View {
        DemoScreen {
            DemoSection(title: "Text roles — .textStyle(role)") {
                Text("Font + theme text colour. Sizes scale with Dynamic Type relative to each role's system text style.")
                    .textStyle(.caption)
                ForEach(TextRole.allCases, id: \.self) { role in
                    HStack(alignment: .firstTextBaseline) {
                        Text(role.rawValue).textStyle(role)
                        Spacer()
                        Text("\(Int(role.size)) pt · \(weightName(role.weight))")
                            .textStyle(.caption)
                    }
                }
            }

            DemoSection(title: "Font only — .lgFont(role)") {
                Text("Use it when you set the colour yourself:")
                    .textStyle(.caption)
                HStack(spacing: theme.spacing.s) {
                    Image(systemName: "bell.fill").lgFont(.h5).foregroundColor(theme.lightGradient2Color)
                    Text("Alert in 5 min").lgFont(.subtitle2).foregroundColor(theme.lightGradient2Color)
                }
            }
        }
    }

    private func weightName(_ weight: Font.Weight) -> String {
        weight == .bold ? "bold" : "regular"
    }
}
