//
//  TokensScreen.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct TokensScreen: View {
    @Environment(\.theme) private var theme
    @Environment(\.lgScaledSize) private var scaledSize
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        DemoScreen {
            DemoSection(title: "Spacing — gaps between elements") {
                spacingRow("xs", theme.spacing.xs)
                spacingRow("s", theme.spacing.s)
                spacingRow("m", theme.spacing.m)
                spacingRow("l", theme.spacing.l)
                spacingRow("xl", theme.spacing.xl)
            }

            DemoSection(title: "Size — dimensions (scaled: ×\(factor))") {
                Text("`theme.size` is fixed; `\\.lgScaledSize` follows Dynamic Type (change it from the toolbar).")
                    .textStyle(.caption)
                HStack(alignment: .bottom, spacing: theme.spacing.s) {
                    sizeBox("xxs", theme.size.xxs, scaledSize.xxs)
                    sizeBox("xs", theme.size.xs, scaledSize.xs)
                    sizeBox("s", theme.size.s, scaledSize.s)
                    sizeBox("m", theme.size.m, scaledSize.m)
                    sizeBox("l", theme.size.l, scaledSize.l)
                }
            }

            DemoSection(title: "Radius — corners") {
                HStack(spacing: theme.spacing.m) {
                    radiusBox("s", theme.radius.s)
                    radiusBox("m", theme.radius.m)
                }
            }
        }
    }

    private var factor: String {
        String(format: "%.2f", dynamicTypeSize.lgScaleFactor)
    }

    private func spacingRow(_ name: String, _ value: CGFloat) -> some View {
        HStack(spacing: theme.spacing.s) {
            Text(name).textStyle(.body2).frame(width: theme.size.s, alignment: .leading)
            Rectangle()
                .fill(theme.lightGradient1Color)
                .frame(width: value * 4, height: theme.size.xxs)
            Text("\(Int(value)) pt").textStyle(.caption)
        }
    }

    private func sizeBox(_ name: String, _ fixed: CGFloat, _ scaled: CGFloat) -> some View {
        VStack(spacing: theme.spacing.xs) {
            RoundedRectangle(cornerRadius: theme.radius.s)
                .fill(theme.lightGradient1Color.opacity(0.4))
                .frame(width: scaled, height: scaled)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.s)
                        .stroke(theme.lightGradient1Color, lineWidth: 1)
                        .frame(width: fixed, height: fixed)
                )
            Text(name).textStyle(.caption)
        }
    }

    private func radiusBox(_ name: String, _ radius: CGFloat) -> some View {
        VStack(spacing: theme.spacing.xs) {
            RoundedRectangle(cornerRadius: radius)
                .fill(theme.lightGradient1Color.opacity(0.4))
                .frame(width: theme.size.l, height: theme.size.m)
            Text("\(name) · \(Int(radius)) pt").textStyle(.caption)
        }
    }
}
