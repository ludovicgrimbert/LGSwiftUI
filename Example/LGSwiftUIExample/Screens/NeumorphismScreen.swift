//
//  NeumorphismScreen.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct NeumorphismScreen: View {
    @Environment(\.theme) private var theme

    private let effects: [(String, NeumorphismEffect)] = [
        ("highShadow", .highShadow), ("highDeep", .highDeep), ("lowShadow", .lowShadow)
    ]

    var body: some View {
        DemoScreen {
            DemoSection(title: "Effects × styles — NeumorphismView") {
                Grid(horizontalSpacing: theme.spacing.l, verticalSpacing: theme.spacing.l) {
                    GridRow {
                        Color.clear.frame(width: theme.size.l, height: 1)
                        ForEach(effects, id: \.0) { name, _ in
                            Text(name).textStyle(.caption)
                        }
                    }
                    row("rounded", .roundedRectangle(cornerRadius: theme.radius.m))
                    row("circle", .circle)
                    row("triangle", .triangle)
                }
            }

            DemoSection(title: ".neumorphic() — sized by an explicit frame") {
                Text("The same composition the apps used to write as a ZStack, in one modifier.")
                    .textStyle(.caption)
                HStack(spacing: theme.spacing.m) {
                    Text("Back").textStyle(.h5)
                        .neumorphic(.roundedRectangle(cornerRadius: theme.radius.m), effect: .lowShadow,
                                    width: theme.size.l, height: theme.size.m)
                    Image(systemName: "plus").lgFont(.h5)
                        .neumorphic(.circle, effect: .highShadow, width: theme.size.m, height: theme.size.m)
                }
            }

            DemoSection(title: ".neumorphic() — sized by its content") {
                Text("Omit width/height and the shape wraps whatever is inside, however long the text gets.")
                    .textStyle(.caption)
                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text("Line 14 — Saint-Lazare").textStyle(.subtitle2)
                    Text("Works planned this weekend between Châtelet and Olympiades. Shuttle buses run every 10 minutes.")
                        .textStyle(.body1)
                }
                .padding(theme.spacing.m)
                .frame(maxWidth: .infinity, alignment: .leading)
                .neumorphic(.roundedRectangle(cornerRadius: theme.radius.m), effect: .lowShadow)
            }
        }
    }

    private func row(_ name: String, _ style: NeumorphismStyle) -> some View {
        GridRow {
            Text(name).textStyle(.caption).frame(width: theme.size.l, alignment: .leading)
            ForEach(effects, id: \.0) { _, effect in
                NeumorphismView(style: style, effect: effect, width: theme.size.m + theme.size.s, height: theme.size.m + theme.size.s,
                                color: theme.darkPrimaryBackgroundColor)
            }
        }
    }
}
