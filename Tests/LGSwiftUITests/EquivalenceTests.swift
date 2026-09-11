//
//  EquivalenceTests.swift
//  LGSwiftUITests
//
//  Proves that the new composable APIs render pixel-for-pixel like the hand-written
//  compositions (and the deprecated APIs) they replace in the apps. No reference file
//  involved: both sides are rendered on the spot and compared.
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

    // MARK: - Neumorphism

    @Test(".neumorphic(width:height:) == ZStack { NeumorphismView; content }", arguments: schemes)
    func neumorphicModifierWithExplicitSize(scheme: ColorScheme) {
        let legacy = ZStack {
            NeumorphismView(style: .roundedRectangle(cornerRadius: 24),
                            level: .high, type: .shadow,
                            width: 160, height: 80,
                            color: fill(scheme))
            Text("Back").textStyle(.h5)
        }
        .snapshotEnvironment(scheme)

        let modern = Text("Back").textStyle(.h5)
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
                NeumorphismView(style: .roundedRectangle(cornerRadius: 24),
                                level: .low, type: .shadow,
                                width: 240, height: 48,
                                color: theme.darkPrimaryBackgroundColor)
                Text("Delete")
                    .foregroundColor(theme.darkTextColor)
                    .font(.system(size: 24, weight: .bold)) // the historical `h5`
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

    // MARK: - Typography

    @available(*, deprecated) // compares against the deprecated per-role modifiers on purpose
    @Test(".textStyle(role) == the deprecated XStyle() modifiers", arguments: schemes)
    func roleTextStyleMatchesLegacyModifiers(scheme: ColorScheme) {
        let legacy = VStack(alignment: .leading, spacing: 4) {
            Text("H1").textStyle(H1Style())
            Text("H3").textStyle(H3Style())
            Text("H5").textStyle(H5Style())
            Text("Subtitle2").textStyle(Subtitle2Style())
            Text("Body1").textStyle(Body1Style())
            Text("Caption").textStyle(CaptionStyle())
            Text("Overline").textStyle(OverlineStyle())
        }
        .snapshotEnvironment(scheme)

        let modern = VStack(alignment: .leading, spacing: 4) {
            Text("H1").textStyle(.h1)
            Text("H3").textStyle(.h3)
            Text("H5").textStyle(.h5)
            Text("Subtitle2").textStyle(.subtitle2)
            Text("Body1").textStyle(.body1)
            Text("Caption").textStyle(.caption)
            Text("Overline").textStyle(.overline)
        }
        .snapshotEnvironment(scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 320, height: 320))
    }

    @available(*, deprecated) // compares against the deprecated environment fonts on purpose
    @Test(".lgFont(role) == .font(environment font) at the default Dynamic Type size")
    func roleFontMatchesEnvironmentFont() {
        struct Legacy: View {
            @Environment(\.caption) var caption
            @Environment(\.h5) var h5
            @Environment(\.subtitle2) var subtitle2
            var body: some View {
                VStack(alignment: .leading) {
                    Text("Caption").font(caption).foregroundColor(.white)
                    Text("H5").font(h5).foregroundColor(.white)
                    Text("Subtitle2").font(subtitle2).foregroundColor(.white)
                }
            }
        }
        let legacy = Legacy().snapshotEnvironment(.dark)

        let modern = VStack(alignment: .leading) {
            Text("Caption").lgFont(.caption).foregroundColor(.white)
            Text("H5").lgFont(.h5).foregroundColor(.white)
            Text("Subtitle2").lgFont(.subtitle2).foregroundColor(.white)
        }
        .snapshotEnvironment(.dark)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 240, height: 160))
    }

    @available(*, deprecated) // compares against the deprecated CustomTextFieldStyle on purpose
    @Test(".lgTextFieldStyle(role:) == .textFieldStyle(CustomTextFieldStyle(font:)) at the default size")
    func roleTextFieldStyleMatchesLegacy() {
        let legacy = TextField("Keyboard or vocal", text: .constant("Netflix"))
            .textFieldStyle(CustomTextFieldStyle(color: theme.darkTextColor,
                                                 font: TextRole.caption.fixedFont,
                                                 cornerRadius: 24,
                                                 strokeColor: theme.darkToggleColor))
            .frame(width: 160, height: 48)
            .snapshotEnvironment(.dark)

        let modern = TextField("Keyboard or vocal", text: .constant("Netflix"))
            .lgTextFieldStyle(color: theme.darkTextColor,
                              role: .caption,
                              cornerRadius: 24,
                              strokeColor: theme.darkToggleColor)
            .frame(width: 160, height: 48)
            .snapshotEnvironment(.dark)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 220, height: 100))
    }

    @Test("UserInputField(role:) == UserInputField(placeholderFont:textFont:) at the default size")
    func roleInputFieldMatchesFontInputField() {
        let legacy = UserInputField(placeholderColor: theme.darkTextColor,
                                    placeholderFont: TextRole.h5.fixedFont,
                                    textColor: theme.darkTextColor,
                                    textFont: TextRole.h5.fixedFont,
                                    placeholderLabel: "Search a station",
                                    text: .constant("Châtelet"))
            .padding()
            .snapshotEnvironment(.dark)

        let modern = UserInputField(placeholderColor: theme.darkTextColor,
                                    textColor: theme.darkTextColor,
                                    role: .h5,
                                    placeholderLabel: "Search a station",
                                    text: .constant("Châtelet"))
            .padding()
            .snapshotEnvironment(.dark)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 320, height: 100))
    }

    // MARK: - Theme glue

    @Test(".lgTheme(_:colorScheme:) == .environment(\\.theme) + .environment(\\.colorScheme)", arguments: schemes)
    func lgThemeMatchesEnvironmentInjection(scheme: ColorScheme) {
        let content = VStack {
            Text("Title").textStyle(.h5)
            Button("Go") {}.buttonStyle(SimpleButtonStyle(maxValue: 160))
        }
        .lgPrimaryBackground()

        let legacy = content
            .environment(\.theme, SnapshotTheme())
            .environment(\.colorScheme, scheme)

        let modern = content
            .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 240, height: 160))
    }

    @available(*, deprecated) // compares against the deprecated backgroundStyle alias on purpose
    @Test(".lgBackground / .lgPrimaryBackground == frame(max) + backgroundStyle(...)", arguments: schemes)
    func lgBackgroundsMatchDeprecatedComposition(scheme: ColorScheme) {
        let legacy = HStack(spacing: 0) {
            Text("Screen").textStyle(.body1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .backgroundStyle(BackgroundPrimaryStyle())
            Text("Card").textStyle(.body1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .backgroundStyle(BackgroundSecondaryStyle())
        }
        .lgTheme(SnapshotTheme(), colorScheme: scheme)

        let modern = HStack(spacing: 0) {
            Text("Screen").textStyle(.body1)
                .lgPrimaryBackground()
            Text("Card").textStyle(.body1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .lgBackground(.secondary)
        }
        .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertRendersIdentically(legacy, modern, size: CGSize(width: 240, height: 120))
    }
}
