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

    @Test("Default values are unchanged")
    func defaultValues() {
        let theme = BareTheme()
        #expect(theme.smallValue == 24)
        #expect(theme.mediumValue == 48)
        #expect(theme.largeValue == 80)
        #expect(theme.veryLargeValue == 160)
    }

    @Test("Default margins are unchanged")
    func defaultMargins() {
        let theme = BareTheme()
        #expect(theme.smallMargin == 8)
        #expect(theme.mediumMargin == 16)
        #expect(theme.largeMargin == 24)
        #expect(theme.veryLargeMargin == 32)
    }

    @Test("Hundreds are unchanged")
    func hundreds() {
        let theme = BareTheme()
        #expect(theme.oneHundred == 100)
        #expect(theme.twoHundred == 200)
    }

    @Test("A theme can override a single token")
    func singleOverride() {
        struct WideTheme: Theme { var largeValue: CGFloat = 120 }
        let theme = WideTheme()
        #expect(theme.largeValue == 120)
        #expect(theme.mediumValue == 48)
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
