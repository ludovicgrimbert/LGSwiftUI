//
//  ComponentsScreen.swift
//  LGSwiftUIExample
//

import SwiftUI
import LGSwiftUI

struct ComponentsScreen: View {
    @Environment(\.theme) private var theme
    @State private var query = ""
    @State private var lastSubmitted = "—"
    @State private var isShowingSheet = false
    @State private var isLoading = false

    var body: some View {
        DemoScreen {
            DemoSection(title: "UserInputField") {
                UserInputField(placeholderColor: theme.lightTextColor.opacity(0.5),
                               textColor: theme.lightTextColor,
                               role: .subtitle2,
                               placeholderLabel: "Search a station",
                               text: $query,
                               searchButtonTapped: { lastSubmitted = $0 },
                               automaticSearchTrigger: { _ in })
                    .neumorphic(.roundedRectangle(cornerRadius: theme.radius.m), effect: .lowShadow)
                Text("Submitted: \(lastSubmitted)").textStyle(.caption)
            }

            DemoSection(title: "BottomSheetView") {
                Button("Present") { isShowingSheet = true }
                    .buttonStyle(NeumorphicButtonStyle(width: theme.size.xl))
            }

            DemoSection(title: "RotateButtonView & LoaderView") {
                HStack(spacing: theme.spacing.m) {
                    RotateButtonView(imageStyle: .clockwiseRotated, color: theme.lightTextColor,
                                     width: theme.size.m, height: theme.size.m, duration: 1) {
                        isLoading = true
                        Task { try? await Task.sleep(for: .seconds(1)); isLoading = false }
                    }
                    .neumorphic(.circle, effect: .highShadow, width: theme.size.m, height: theme.size.m)
                    if isLoading {
                        LoaderView(tint: theme.lightGradient1Color)
                    }
                }
            }

            DemoSection(title: "CustomIconLabelStyle") {
                Label("Notifications", systemImage: "bell").labelStyle(CustomIconLabelStyle(color: theme.lightGradient2Color, size: 1))
                    .textStyle(.body1)
                Label("Larger icon box", systemImage: "gear").labelStyle(CustomIconLabelStyle(color: theme.lightGradient1Color, size: 1.5))
                    .textStyle(.body1)
            }

            DemoSection(title: "ScrollableContainerView") {
                Text("Scrolls only when its content does not fit.").textStyle(.caption)
                ScrollableContainerView { _ in
                    VStack(spacing: theme.spacing.xs) {
                        ForEach(0..<3, id: \.self) { index in
                            Text("Row \(index)").textStyle(.body1)
                        }
                    }
                }
                .frame(height: theme.size.l)
                .lgBackground(.secondary)
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            BottomSheetView(title: "Delete this favorite?",
                            description: "This action cannot be undone.",
                            actionTitle: "Delete",
                            action: { isShowingSheet = false },
                            cancelTitle: "Cancel",
                            cancel: { isShowingSheet = false })
                .presentationDetents([.height(theme.size.xl + theme.size.l)])
        }
    }
}
