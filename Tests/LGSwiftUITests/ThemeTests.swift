//
//  ThemeTests.swift
//  LGSwiftUITests
//
//  Locks the numeric tokens and the colour helpers' semantics. These values are what
//  the consuming apps' layouts are built on; they must not drift during refactors.
//

import SwiftUI
import Testing
import LGSwiftUI

@Suite("Theme tokens")
struct ThemeTokenTests {

    private struct BareTheme: Theme {}

    @Test("Default sizes are unchanged")
    func defaultSizes() {
        let theme = BareTheme()
        #expect(theme.size == ThemeSize(xxs: 8, xs: 16, s: 24, m: 48, l: 80, xl: 160))
    }

    @Test("Default spacing is unchanged")
    func defaultSpacing() {
        let theme = BareTheme()
        #expect(theme.spacing == ThemeSpacing(xs: 8, s: 16, m: 24, l: 32, xl: 48))
    }

    @Test("Default radii match the values apps used as corner radii")
    func defaultRadii() {
        let theme = BareTheme()
        #expect(theme.radius == ThemeRadius(s: 8, m: 24))
    }

    @Test("A theme can override a single group")
    func singleOverride() {
        struct WideTheme: Theme { var size = ThemeSize(l: 120) }
        let theme = WideTheme()
        #expect(theme.size.l == 120)
        #expect(theme.size.m == 48)
        #expect(theme.spacing.m == 24)
    }
}

@Suite("Dynamic Type scaling")
struct ScalingTests {

    @Test("Default Dynamic Type setting leaves sizes untouched")
    func identityAtDefault() {
        let size = ThemeSize()
        #expect(DynamicTypeSize.large.lgScaleFactor == 1)
        #expect(size.scaled(for: .large) == size)
    }

    @Test("Sizes grow with accessibility settings, following the .body curve")
    func growsWithAccessibility() {
        let size = ThemeSize()
        let scaled = size.scaled(for: .accessibility3)
        #expect(abs(DynamicTypeSize.accessibility3.lgScaleFactor - 40.0 / 17.0) < 0.0001)
        #expect(scaled.m > size.m)
        #expect(abs(scaled.m - 48 * 40.0 / 17.0) < 0.0001)
    }

    @Test("Sizes shrink for the smallest settings")
    func shrinksForSmall() {
        #expect(DynamicTypeSize.xSmall.lgScaleFactor < 1)
    }

    @Test("Text roles keep their historical base metrics")
    func textRoleMetrics() {
        #expect(TextRole.h1.size == 96 && TextRole.h1.weight == .bold)
        #expect(TextRole.h2.size == 60 && TextRole.h2.weight == .regular)
        #expect(TextRole.h3.size == 48 && TextRole.h3.weight == .bold)
        #expect(TextRole.h4.size == 34 && TextRole.h4.weight == .regular)
        #expect(TextRole.h5.size == 24 && TextRole.h5.weight == .bold)
        #expect(TextRole.h6.size == 20 && TextRole.h6.weight == .regular)
        #expect(TextRole.subtitle1.size == 16 && TextRole.subtitle1.weight == .regular)
        #expect(TextRole.subtitle2.size == 16 && TextRole.subtitle2.weight == .bold)
        #expect(TextRole.body1.size == 14 && TextRole.body1.weight == .regular)
        #expect(TextRole.body2.size == 14 && TextRole.body2.weight == .bold)
        #expect(TextRole.caption.size == 12 && TextRole.caption.weight == .regular)
        #expect(TextRole.caption2.size == 12 && TextRole.caption2.weight == .bold)
        #expect(TextRole.overline.size == 10 && TextRole.overline.weight == .regular)
    }
}

@Suite("Color helpers")
struct ColorHelperTests {

    private func rgba(_ color: Color) -> (r: Double, g: Double, b: Double, a: Double) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(color).getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
    }

    @Test("Color(red:green:blue:) takes 0-255 components")
    func rgb255() {
        let components = rgba(Color(red: 255, green: 0, blue: 51))
        #expect(abs(components.r - 1.0) < 0.001)
        #expect(abs(components.g - 0.0) < 0.001)
        #expect(abs(components.b - 0.2) < 0.001)
        #expect(abs(components.a - 1.0) < 0.001)
    }

    @Test("Color(red:green:blue:opacity:) keeps opacity in 0...1")
    func rgb255Opacity() {
        let components = rgba(Color(red: 30, green: 30, blue: 30, opacity: 0.5))
        #expect(abs(components.r - 30.0 / 255.0) < 0.001)
        #expect(abs(components.a - 0.5) < 0.001)
    }

    @Test("Color(hex:) decodes RRGGBB")
    func hex() {
        let components = rgba(Color(hex: 0xFF8000))
        #expect(abs(components.r - 1.0) < 0.001)
        #expect(abs(components.g - 128.0 / 255.0) < 0.001)
        #expect(abs(components.b - 0.0) < 0.001)
    }
}
