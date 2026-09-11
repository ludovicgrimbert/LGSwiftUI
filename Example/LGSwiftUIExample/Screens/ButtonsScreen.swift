//
//  ButtonsScreen.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct ButtonsScreen: View {
    @Environment(\.theme) private var theme
    @State private var isMuted = false
    @State private var status: ThemeStatus = .initial

    var body: some View {
        DemoScreen {
            DemoSection(title: "Text buttons") {
                Text("Heights come from \\.lgScaledSize: they grow with the text size.")
                    .textStyle(.caption)
                Button("Simple") {}.buttonStyle(SimpleButtonStyle(maxValue: theme.size.xl))
                Button("Simple, leading") {}.buttonStyle(SimpleButtonStyle(maxValue: theme.size.xl, textIsCenter: false))
                Button("Clear") {}.buttonStyle(ClearButtonStyle(maxValue: theme.size.xl))
                Button("Primary") {}.buttonStyle(PrimaryButtonStyle(maxValue: theme.size.xl))
                Button("Rectangle") {}.buttonStyle(RectangleButtonStyle(maxValue: theme.size.xl))
            }

            DemoSection(title: "Round buttons") {
                HStack(spacing: theme.spacing.m) {
                    Button { } label: { Image(systemName: "power") }
                        .buttonStyle(CircleButtonStyle(maxValue: theme.size.m))
                    Button { isMuted.toggle() } label: { Image(systemName: isMuted ? "speaker.slash" : "speaker") }
                        .buttonStyle(CircleToggleButtonStyle(maxValue: theme.size.m, isToggle: isMuted))
                    Button { status = status.next } label: { Image(systemName: "circle.dotted") }
                        .buttonStyle(CircleStatusButtonStyle(maxValue: theme.size.m, status: status))
                }
                Text("Tap the second to toggle, the third to cycle its status (\(String(describing: status))).")
                    .textStyle(.caption)
            }

            DemoSection(title: "Neumorphic buttons") {
                Button("Default (low shadow, h5)") {}
                    .buttonStyle(NeumorphicButtonStyle(width: theme.size.xl + theme.size.l))
                Button("Raised, body1") {}
                    .buttonStyle(NeumorphicButtonStyle(effect: .highShadow, width: theme.size.xl + theme.size.l, role: .body1))
                Button { } label: { Image(systemName: "chevron.left") }
                    .buttonStyle(NeumorphicButtonStyle(style: .circle, width: theme.size.m))
            }
        }
    }
}

private extension ThemeStatus {
    var next: ThemeStatus {
        switch self {
        case .initial: .progress
        case .progress: .accepted
        case .accepted: .refused
        case .refused: .initial
        }
    }
}
