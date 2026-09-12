//
//  ComponentSnapshotTests.swift
//  LGSwiftUITests
//
//  Pixel-level regression tests for every public component, in both colour schemes.
//  These exist to prove that internal refactors of the library do not change what the
//  consuming apps render. If a snapshot fails after an *intentional* visual change,
//  re-record it (see SnapshotAssert.swift) and review the diff in the commit.
//
//  `LoaderView` is deliberately not snapshotted: it wraps an animated `ProgressView`
//  whose spinner phase is not deterministic across renders.
//

import SwiftUI
import Testing
import LGSwiftUI

/// File-scoped (not a member) so the `@Test(arguments:)` macro can read it outside the
/// suite's main-actor isolation.
private let schemes: [ColorScheme] = [.dark, .light]

@MainActor
@Suite("Component snapshots")
struct ComponentSnapshotTests {

    private static func suffix(_ scheme: ColorScheme) -> String {
        scheme == .dark ? "dark" : "light"
    }

    // MARK: - Text

    private static var allTextRoles: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(TextRole.allCases, id: \.self) { role in
                Text(role.rawValue.capitalized).textStyle(role)
            }
        }
    }

    @Test("Text styles", arguments: schemes)
    func textStyles(scheme: ColorScheme) {
        let view = Self.allTextRoles.snapshotEnvironment(scheme)
        assertSnapshot(of: view, named: "TextStyles-\(Self.suffix(scheme))", size: CGSize(width: 320, height: 420))
    }

    @Test("Text styles scale with Dynamic Type")
    func textStylesAccessibility() {
        let view = Self.allTextRoles
            .snapshotEnvironment(.dark)
            .environment(\.dynamicTypeSize, .accessibility3)
        assertSnapshot(of: view, named: "TextStyles-dark-accessibility3", size: CGSize(width: 480, height: 720))
    }

    // MARK: - Buttons

    private static var allButtons: some View {
        VStack(spacing: 12) {
            Button("Simple") {}.buttonStyle(SimpleButtonStyle(maxValue: 200))
            Button("Simple leading") {}.buttonStyle(SimpleButtonStyle(maxValue: 200, textIsCenter: false))
            Button("Clear") {}.buttonStyle(ClearButtonStyle(maxValue: 200))
            Button("Primary") {}.buttonStyle(PrimaryButtonStyle(maxValue: 200))
            Button("Rectangle") {}.buttonStyle(RectangleButtonStyle(maxValue: 200))
            HStack(spacing: 12) {
                Button { } label: { Image(systemName: "power").frame(width: 48, height: 48) }
                    .buttonStyle(CircleButtonStyle(maxValue: 48))
                Button { } label: { Image(systemName: "mic").frame(width: 48, height: 48) }
                    .buttonStyle(CircleToggleButtonStyle(maxValue: 48, isToggle: true))
                Button { } label: { Image(systemName: "mic").frame(width: 48, height: 48) }
                    .buttonStyle(CircleToggleButtonStyle(maxValue: 48, isToggle: false))
            }
            HStack(spacing: 12) {
                Button { } label: { Image(systemName: "circle").frame(width: 48, height: 48) }
                    .buttonStyle(CircleStatusButtonStyle(maxValue: 48, status: .initial))
                Button { } label: { Image(systemName: "circle").frame(width: 48, height: 48) }
                    .buttonStyle(CircleStatusButtonStyle(maxValue: 48, status: .progress))
                Button { } label: { Image(systemName: "circle").frame(width: 48, height: 48) }
                    .buttonStyle(CircleStatusButtonStyle(maxValue: 48, status: .accepted))
                Button { } label: { Image(systemName: "circle").frame(width: 48, height: 48) }
                    .buttonStyle(CircleStatusButtonStyle(maxValue: 48, status: .refused))
            }
        }
    }

    @Test("Button styles", arguments: schemes)
    func buttonStyles(scheme: ColorScheme) {
        let view = Self.allButtons.snapshotEnvironment(scheme)
        assertSnapshot(of: view, named: "ButtonStyles-\(Self.suffix(scheme))", size: CGSize(width: 320, height: 440))
    }

    @Test("Button styles scale with Dynamic Type")
    func buttonStylesAccessibility() {
        let view = Self.allButtons
            .snapshotEnvironment(.dark)
            .environment(\.dynamicTypeSize, .accessibility3)
        // Wider than the default-size canvas: the circle button styles now scale their own
        // diameter with Dynamic Type (see ButtonStyle.swift), so the round-button row is
        // considerably wider at accessibility3 — a fixed 320pt canvas clipped it.
        assertSnapshot(of: view, named: "ButtonStyles-dark-accessibility3", size: CGSize(width: 480, height: 640))
    }

    @Test("Neumorphic button", arguments: schemes)
    func neumorphicButton(scheme: ColorScheme) {
        let view = VStack(spacing: 24) {
            Button("Neumorphic") {}.buttonStyle(NeumorphicButtonStyle(width: 200))
            Button("Raised") {}.buttonStyle(NeumorphicButtonStyle(effect: .highShadow, width: 200, role: .body1))
            Button { } label: { Image(systemName: "chevron.left") }
                .buttonStyle(NeumorphicButtonStyle(style: .circle, width: 48))
        }
        .snapshotEnvironment(scheme)
        assertSnapshot(of: view, named: "NeumorphicButton-\(Self.suffix(scheme))", size: CGSize(width: 280, height: 240))
    }

    // MARK: - Neumorphism

    @Test("Neumorphism shapes", arguments: schemes)
    func neumorphism(scheme: ColorScheme) {
        let theme = SnapshotTheme()
        let fill = scheme == .dark ? theme.darkPrimaryBackgroundColor : theme.lightPrimaryBackgroundColor
        let styles: [NeumorphismStyle] = [.roundedRectangle(cornerRadius: 24), .circle, .triangle]

        let view = VStack(spacing: 32) {
            ForEach(Array(styles.enumerated()), id: \.offset) { _, style in
                HStack(spacing: 32) {
                    NeumorphismView(style: style, effect: .highShadow, width: 72, height: 72, color: fill)
                    NeumorphismView(style: style, effect: .highDeep, width: 72, height: 72, color: fill)
                    NeumorphismView(style: style, effect: .lowShadow, width: 72, height: 72, color: fill)
                }
            }
        }
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "Neumorphism-\(Self.suffix(scheme))", size: CGSize(width: 360, height: 380))
    }

    // MARK: - Composite views

    @Test("Bottom sheet", arguments: schemes)
    func bottomSheet(scheme: ColorScheme) {
        let view = BottomSheetView(
            title: "Delete this favorite?",
            description: "This action cannot be undone.",
            actionTitle: "Delete",
            action: nil,
            cancelTitle: "Cancel",
            cancel: nil
        )
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "BottomSheet-\(Self.suffix(scheme))", size: CGSize(width: 360, height: 300))
    }

    @Test("User input field", arguments: schemes)
    func userInputField(scheme: ColorScheme) {
        let theme = SnapshotTheme()
        let text = scheme == .dark ? theme.darkTextColor : theme.lightTextColor
        let view = VStack(spacing: 16) {
            UserInputField(
                placeholderColor: text.opacity(0.5),
                placeholderFont: .system(size: 14),
                textColor: text,
                textFont: .system(size: 14),
                placeholderLabel: "Search a station",
                text: .constant("")
            )
            UserInputField(
                placeholderColor: text.opacity(0.5),
                placeholderFont: .system(size: 14),
                textColor: text,
                textFont: .system(size: 14),
                placeholderLabel: "Search a station",
                text: .constant("Châtelet")
            )
        }
        .padding()
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "UserInputField-\(Self.suffix(scheme))", size: CGSize(width: 360, height: 180))
    }

    @Test("Rotate button", arguments: schemes)
    func rotateButton(scheme: ColorScheme) {
        let view = HStack(spacing: 24) {
            RotateButtonView(imageStyle: .circlePath, color: .orange, width: 48, height: 48)
            RotateButtonView(imageStyle: .clockwise, color: .orange, width: 48, height: 48, ratio: 2)
        }
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "RotateButton-\(Self.suffix(scheme))", size: CGSize(width: 200, height: 100))
    }

    @Test("Icon label style", arguments: schemes)
    func iconLabelStyle(scheme: ColorScheme) {
        let view = VStack(alignment: .leading, spacing: 16) {
            Label("Settings", systemImage: "gear").labelStyle(CustomIconLabelStyle(color: .orange, size: 1))
            Label("Larger", systemImage: "bell").labelStyle(CustomIconLabelStyle(color: .blue, size: 1.5))
        }
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "IconLabel-\(Self.suffix(scheme))", size: CGSize(width: 240, height: 140))
    }

    @Test("Background styles", arguments: schemes)
    func backgroundStyles(scheme: ColorScheme) {
        let view = HStack(spacing: 0) {
            Text("Primary").textStyle(.body1).frame(maxWidth: .infinity, maxHeight: .infinity)
                .lgBackground(.primary)
            Text("Secondary").textStyle(.body1).frame(maxWidth: .infinity, maxHeight: .infinity)
                .lgBackground(.secondary)
        }
        .lgTheme(SnapshotTheme(), colorScheme: scheme)

        assertSnapshot(of: view, named: "Backgrounds-\(Self.suffix(scheme))", size: CGSize(width: 240, height: 80))
    }

    @Test("Scrollable container", arguments: schemes)
    func scrollableContainer(scheme: ColorScheme) {
        let view = ScrollableContainerView { _ in
            VStack(spacing: 8) {
                ForEach(0..<4, id: \.self) { index in
                    Text("Row \(index)").textStyle(.body1)
                }
            }
        }
        .snapshotEnvironment(scheme)

        assertSnapshot(of: view, named: "ScrollableContainer-\(Self.suffix(scheme))", size: CGSize(width: 240, height: 200))
    }
}
