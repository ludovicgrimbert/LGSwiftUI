//
//  GalleryView.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct GalleryView: View {
    @Environment(DemoSettings.self) private var settings
    @Environment(\.theme) private var theme

    private enum Section: String, CaseIterable, Identifiable {
        case tokens = "Tokens"
        case typography = "Typography"
        case buttons = "Buttons"
        case neumorphism = "Neumorphism"
        case components = "Components"

        var id: String { rawValue }

        var symbol: String {
            switch self {
            case .tokens: "ruler"
            case .typography: "textformat"
            case .buttons: "button.horizontal"
            case .neumorphism: "circle.lefthalf.filled"
            case .components: "square.grid.2x2"
            }
        }
    }

    var body: some View {
        @Bindable var settings = settings
        NavigationStack {
            List(Section.allCases) { section in
                NavigationLink(value: section) {
                    Label(section.rawValue, systemImage: section.symbol)
                        .labelStyle(CustomIconLabelStyle(color: theme.lightGradient1Color, size: 1))
                        .textStyle(.body1)
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .lgBackground(.primary)
            .navigationTitle("LGSwiftUI")
            .navigationDestination(for: Section.self) { section in
                Group {
                    switch section {
                    case .tokens: TokensScreen()
                    case .typography: TypographyScreen()
                    case .buttons: ButtonsScreen()
                    case .neumorphism: NeumorphismScreen()
                    case .components: ComponentsScreen()
                    }
                }
                .navigationTitle(section.rawValue)
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Appearance", selection: $settings.colorScheme) {
                            Text("System").tag(ColorScheme?.none)
                            Text("Light").tag(ColorScheme?.some(.light))
                            Text("Dark").tag(ColorScheme?.some(.dark))
                        }
                        Picker("Text size", selection: $settings.dynamicTypeSize) {
                            ForEach(DynamicTypeSize.demoChoices, id: \.self) { size in
                                Text(size.demoLabel).tag(size)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

/// A titled block used by every screen.
struct DemoSection<Content: View>: View {
    @Environment(\.theme) private var theme
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.s) {
            Text(title).textStyle(.h6)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.spacing.m)
    }
}

/// Screen scaffold: scrollable, padded, on the primary background.
struct DemoScreen<Content: View>: View {
    @Environment(\.theme) private var theme
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.m) {
                content
            }
            .padding(.vertical, theme.spacing.m)
        }
        .lgPrimaryBackground()
    }
}
