//
//  EquivalenceTests.swift
//  LGSwiftUITests
//
//  Proves that the new composable APIs render pixel-for-pixel like the hand-written
//  compositions they replace in the apps. No reference file involved: both sides are
//  rendered on the spot and compared.
//

import SwiftUI
import Testing
import LGSwiftUI

private let schemes: [ColorScheme] = [.dark, .light]

@MainActor
@Suite("New APIs render like the compositions they replace")
struct EquivalenceTests {

    private let theme = SnapshotTheme()

    private func fill(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? theme.darkPrimaryBackgroundColor : theme.lightPrimaryBackgroundColor
    }

    private func text(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? theme.darkTextColor : theme.lightTextColor
    }

    @Test(".neumorphic(width:height:) == ZStack { NeumorphismView; content }", arguments: schemes)
    func neumorphicModifierWithExplicitSize(scheme: ColorScheme) {
        let legacy = ZStack {
            NeumorphismView(style: .roundedRectangle(cornerRadius: 24),
                            level: .high, type: .shadow,
                            width: 160, height: 80,
                            color: fill(scheme))
            Text("Back").textStyle(H5Style())
        }
        .snapshotEnvironment(scheme)

        let modern = Text("Back").textStyle(H5Style())
            .neumorphic(.roundedRectangle(cornerRadius: 24), effect: .highShadow, width: 160, height: 80)
            .snapshotEnvironment(scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 260, height: 180))
    }

    @Test(".neumorphic circle and low shadow", arguments: schemes)
    func neumorphicCircleLowShadow(scheme: ColorScheme) {
        let legacy = ZStack {
            NeumorphismView(style: .circle, level: .low, type: .shadow, width: 96, height: 96, color: fill(scheme))
            Image(systemName: "arrow.clockwise").font(.system(size: 24)).foregroundColor(text(scheme))
        }
        .snapshotEnvironment(scheme)

        let modern = Image(systemName: "arrow.clockwise").font(.system(size: 24)).foregroundColor(text(scheme))
            .neumorphic(.circle, effect: .lowShadow, width: 96, height: 96)
            .snapshotEnvironment(scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 180, height: 180))
    }

    @Test("NeumorphismView(effect:) == NeumorphismView(level:type:)", arguments: schemes)
    func effectInitializerMatchesLevelType(scheme: ColorScheme) {
        let pairs: [(NeumorphismLevel, NeumorphismType, NeumorphismEffect)] = [
            (.high, .shadow, .highShadow), (.high, .deep, .highDeep), (.low, .shadow, .lowShadow)
        ]
        for (level, type, effect) in pairs {
            let legacy = NeumorphismView(style: .triangle, level: level, type: type, width: 96, height: 96, color: fill(scheme))
                .snapshotEnvironment(scheme)
            let modern = NeumorphismView(style: .triangle, effect: effect, width: 96, height: 96, color: fill(scheme))
                .snapshotEnvironment(scheme)
            assertRendersIdentically(legacy, modern, size: CGSize(width: 160, height: 160))
        }
    }

    @Test("NeumorphicButtonStyle == hand-written NeuButtonView (dark)")
    func neumorphicButtonStyleMatchesLegacyComposition() {
        // The composition BottomSheetView and Pampuko's NotificationSheetView used to write.
        let legacy = Button(action: {}) {
            ZStack {
                NeumorphismView(style: .roundedRectangle(cornerRadius: theme.smallValue),
                                level: .low, type: .shadow,
                                width: 240, height: theme.mediumValue,
                                color: theme.darkPrimaryBackgroundColor)
                Text("Delete")
                    .foregroundColor(theme.darkTextColor)
                    .font(.system(size: 24, weight: .bold)) // the default `h5`
            }
        }
        .snapshotEnvironment(.dark)

        let modern = Button("Delete") {}
            .buttonStyle(NeumorphicButtonStyle(width: 240))
            .snapshotEnvironment(.dark)

        // Shapes match exactly; the label's glyphs are anti-aliased slightly differently by
        // the default button style than by a custom `ButtonStyle` (~0.1% of pixels, sub-pixel
        // text edges). Same thresholds as the reference snapshots.
        assertRendersIdentically(legacy, modern, size: CGSize(width: 300, height: 120),
                                 precision: 0.995, channelTolerance: 8)
    }

    @Test(".lgTheme(_:colorScheme:) == .environment(\\.theme) + .environment(\\.colorScheme)", arguments: schemes)
    func lgThemeMatchesEnvironmentInjection(scheme: ColorScheme) {
        let content = VStack {
            Text("Title").textStyle(H5Style())
            Button("Go") {}.buttonStyle(SimpleButtonStyle(maxValue: 160))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundStyle(BackgroundPrimaryStyle())

        let legacy = content
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, scheme)

        let modern = content
            .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 240, height: 160))
    }

    @Test(".lgPrimaryBackground() == frame(max) + backgroundStyle(primary)", arguments: schemes)
    func lgPrimaryBackgroundMatchesComposition(scheme: ColorScheme) {
        let legacy = Text("Screen").textStyle(Body1Style())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle(BackgroundPrimaryStyle())
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, scheme)

        let modern = Text("Screen").textStyle(Body1Style())
            .lgPrimaryBackground()
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 200, height: 120))
    }
}
