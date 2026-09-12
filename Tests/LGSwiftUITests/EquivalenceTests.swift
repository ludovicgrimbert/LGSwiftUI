//
//  EquivalenceTests.swift
//  LGSwiftUITests
//
//  Proves that the composable APIs render pixel-for-pixel like the hand-written
//  compositions they replace in the apps. No reference file involved: both sides are
//  rendered on the spot and compared.
//

import SwiftUI
import Testing
import LGSwiftUI

private let schemes: [ColorScheme] = [.dark, .light]

@MainActor
@Suite("Composable APIs render like the compositions they replace")
struct EquivalenceTests {

    private let theme = SnapshotTheme()

    private func fill(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? theme.darkPrimaryBackgroundColor : theme.lightPrimaryBackgroundColor
    }

    private func text(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? theme.darkTextColor : theme.lightTextColor
    }

    // MARK: - Neumorphism

    @Test(".neumorphic(width:height:) == ZStack { NeumorphismView; content }", arguments: schemes)
    func neumorphicModifierWithExplicitSize(scheme: ColorScheme) {
        let composition = ZStack {
            NeumorphismView(style: .roundedRectangle(cornerRadius: 24), effect: .highShadow,
                            width: 160, height: 80, color: fill(scheme))
            Text("Back").textStyle(.h5)
        }
        .snapshotEnvironment(scheme)

        let modifier = Text("Back").textStyle(.h5)
            .neumorphic(.roundedRectangle(cornerRadius: 24), effect: .highShadow, width: 160, height: 80)
            .snapshotEnvironment(scheme)

        assertRendersIdentically(composition, modifier, size: CGSize(width: 260, height: 180))
    }

    @Test(".frame(minWidth:minHeight:).neumorphic() == .neumorphic(width:height:) when the content fits", arguments: schemes)
    func minimumSizedNeumorphicMatchesFixedSize(scheme: ColorScheme) {
        let fixed = Text("Back").textStyle(.h5)
            .neumorphic(.roundedRectangle(cornerRadius: 24), effect: .lowShadow, width: 160, height: 48)
            .snapshotEnvironment(scheme)

        let minimum = Text("Back").textStyle(.h5)
            .frame(minWidth: 160, minHeight: 48)
            .neumorphic(.roundedRectangle(cornerRadius: 24), effect: .lowShadow)
            .snapshotEnvironment(scheme)

        assertRendersIdentically(fixed, minimum, size: CGSize(width: 260, height: 140))
    }

    @Test(".neumorphic circle and low shadow", arguments: schemes)
    func neumorphicCircleLowShadow(scheme: ColorScheme) {
        let composition = ZStack {
            NeumorphismView(style: .circle, effect: .lowShadow, width: 96, height: 96, color: fill(scheme))
            Image(systemName: "arrow.clockwise").font(.system(size: 24)).foregroundColor(text(scheme))
        }
        .snapshotEnvironment(scheme)

        let modifier = Image(systemName: "arrow.clockwise").font(.system(size: 24)).foregroundColor(text(scheme))
            .neumorphic(.circle, effect: .lowShadow, width: 96, height: 96)
            .snapshotEnvironment(scheme)

        assertRendersIdentically(composition, modifier, size: CGSize(width: 180, height: 180))
    }

    @Test("NeumorphicButtonStyle == hand-written neumorphic text button (dark)")
    func neumorphicButtonStyleMatchesComposition() {
        let composition = Button(action: {}) {
            ZStack {
                NeumorphismView(style: .roundedRectangle(cornerRadius: 24), effect: .lowShadow,
                                width: 240, height: 48, color: theme.darkPrimaryBackgroundColor)
                Text("Delete")
                    .foregroundColor(theme.darkTextColor)
                    .font(TextRole.h5.fixedFont)
            }
        }
        .snapshotEnvironment(.dark)

        let styled = Button("Delete") {}
            .buttonStyle(NeumorphicButtonStyle(width: 240))
            .snapshotEnvironment(.dark)

        // Shapes match exactly; the label's glyphs are anti-aliased slightly differently by
        // the default button style than by a custom `ButtonStyle` (~0.1% of pixels, sub-pixel
        // text edges). Same thresholds as the reference snapshots.
        assertRendersIdentically(composition, styled, size: CGSize(width: 300, height: 120),
                                 precision: 0.995, channelTolerance: 8)
    }

    // MARK: - Typography

    @Test(".lgFont(role) == .font(role.fixedFont) at the default Dynamic Type size")
    func roleFontMatchesFixedFontAtDefaultSize() {
        let fixed = VStack(alignment: .leading) {
            Text("Caption").font(TextRole.caption.fixedFont).foregroundColor(.white)
            Text("H5").font(TextRole.h5.fixedFont).foregroundColor(.white)
            Text("Subtitle2").font(TextRole.subtitle2.fixedFont).foregroundColor(.white)
        }
        .snapshotEnvironment(.dark)

        let scaled = VStack(alignment: .leading) {
            Text("Caption").lgFont(.caption).foregroundColor(.white)
            Text("H5").lgFont(.h5).foregroundColor(.white)
            Text("Subtitle2").lgFont(.subtitle2).foregroundColor(.white)
        }
        .snapshotEnvironment(.dark)

        assertRendersIdentically(fixed, scaled, size: CGSize(width: 240, height: 160))
    }

    @Test(".lgTextFieldStyle(role:) == .lgTextFieldStyle(font: role.fixedFont) at the default size")
    func roleTextFieldStyleMatchesFixedFont() {
        let fixed = TextField("Keyboard or vocal", text: .constant("Netflix"))
            .lgTextFieldStyle(color: theme.darkTextColor, font: TextRole.caption.fixedFont,
                              cornerRadius: 24, strokeColor: theme.darkToggleColor)
            .frame(width: 160, height: 48)
            .snapshotEnvironment(.dark)

        let scaled = TextField("Keyboard or vocal", text: .constant("Netflix"))
            .lgTextFieldStyle(color: theme.darkTextColor, role: .caption,
                              cornerRadius: 24, strokeColor: theme.darkToggleColor)
            .frame(width: 160, height: 48)
            .snapshotEnvironment(.dark)

        assertRendersIdentically(fixed, scaled, size: CGSize(width: 220, height: 100))
    }

    @Test("UserInputField(role:) == UserInputField(placeholderFont:textFont:) at the default size")
    func roleInputFieldMatchesFontInputField() {
        let fixed = UserInputField(placeholderColor: theme.darkTextColor,
                                   placeholderFont: TextRole.h5.fixedFont,
                                   textColor: theme.darkTextColor,
                                   textFont: TextRole.h5.fixedFont,
                                   placeholderLabel: "Search a station",
                                   text: .constant("Châtelet"))
            .padding()
            .snapshotEnvironment(.dark)

        let scaled = UserInputField(placeholderColor: theme.darkTextColor,
                                    textColor: theme.darkTextColor,
                                    role: .h5,
                                    placeholderLabel: "Search a station",
                                    text: .constant("Châtelet"))
            .padding()
            .snapshotEnvironment(.dark)

        assertRendersIdentically(fixed, scaled, size: CGSize(width: 320, height: 100))
    }

    // MARK: - Theme glue

    @Test(".lgTheme(_:colorScheme:) == .environment(\\.theme) + .environment(\\.colorScheme)", arguments: schemes)
    func lgThemeMatchesEnvironmentInjection(scheme: ColorScheme) {
        let content = VStack {
            Text("Title").textStyle(.h5)
            Button("Go") {}.buttonStyle(SimpleButtonStyle(maxValue: 160))
        }
        .lgPrimaryBackground()

        let environment = content
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, scheme)

        let modifier = content
            .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertRendersIdentically(environment, modifier, size: CGSize(width: 240, height: 160))
    }

    @Test(".lgPrimaryBackground() == frame(max) + lgBackground(.primary)", arguments: schemes)
    func lgPrimaryBackgroundMatchesComposition(scheme: ColorScheme) {
        let composition = Text("Screen").textStyle(.body1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .lgBackground(.primary)
            .lgTheme(SnapshotTheme(), colorScheme: scheme)

        let helper = Text("Screen").textStyle(.body1)
            .lgPrimaryBackground()
            .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertRendersIdentically(composition, helper, size: CGSize(width: 200, height: 120))
    }
}
