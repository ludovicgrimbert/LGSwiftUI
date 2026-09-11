# LGSwiftUI

A small SwiftUI design system: theme tokens, text/button/background styles and a
handful of components (neumorphic shapes, bottom sheet, input field, …). iOS 17+,
Swift 6 language mode, no dependencies.

## Installation

```swift
.package(url: "https://github.com/ludovicgrimbert/LGSwiftUI", exact: "0.3.0")
```

The package is `0.x`: minor versions may contain breaking changes, so pin an exact
version (or `upToNextMinor`) rather than `upToNextMajor`.

## Theme

Conform to `Theme` and override only what you need — every requirement has a default
(system semantic colours, 8/16/24/32 margins, 24/48/80/160 values):

```swift
struct AppTheme: Theme {
    var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30)
    var darkTextColor: Color = .white
    var darkToggleColor: Color = .orange
}
```

Inject it once at the root, along with the colour scheme your app wants:

```swift
ContentView()
    .environment(\.theme, AppTheme())
    .preferredColorScheme(.dark)
```

Every style reads `\.theme` and `\.colorScheme` from the environment and picks the
matching `light*`/`dark*` colour.

### ⚠️ `Color(red:green:blue:opacity:)` takes 0-255

`LGSwiftUI` shadows SwiftUI's initializer of the same name. In any file that imports
`LGSwiftUI`, `Color(red: 30, green: 30, blue: 30)` means **30/255**, not a saturated
white. See `Extension/ExtColor.swift`. `Color(hex: 0x1E1E1E)` is also available.

## What's in the box

| Area | API |
|---|---|
| Tokens | `Theme` (`smallValue`…`veryLargeValue`, `smallMargin`…`veryLargeMargin`, `oneHundred`, `twoHundred`, colours) |
| Fonts | environment keys `\.h1`…`\.h6`, `\.subtitle1/2`, `\.body1/2`, `\.caption`, `\.caption2`, `\.overline` |
| Text styles | `Text.textStyle(H1Style())` … `OverlineStyle()` |
| Backgrounds | `View.backgroundStyle(BackgroundPrimaryStyle())`, `BackgroundSecondaryStyle()` |
| Buttons | `SimpleButtonStyle`, `ClearButtonStyle`, `PrimaryButtonStyle`, `RectangleButtonStyle`, `CircleButtonStyle`, `CircleToggleButtonStyle`, `CircleStatusButtonStyle` |
| Text fields | `View.lgTextFieldStyle(color:font:cornerRadius:strokeColor:lineWidth:)` |
| Labels | `CustomIconLabelStyle(color:size:)` |
| Neumorphism | `NeumorphismView(style:level:type:width:height:color:)`, `Triangle` |
| Components | `BottomSheetView`, `UserInputField`, `RotateButtonView`, `ScrollableContainerView`, `LoaderView` |
| Helpers | `View.overlayWithProxy(alignment:content:)` |

## Development

The package is iOS-only, so build and test through an iOS simulator:

```sh
xcodebuild test -scheme LGSwiftUI -destination 'platform=iOS Simulator,name=iPhone 17'
```

### Snapshot tests

`Tests/LGSwiftUITests/ComponentSnapshotTests.swift` renders every component with
`ImageRenderer` in both colour schemes and compares the pixels with the PNGs committed
in `Tests/LGSwiftUITests/__Snapshots__/`. They exist so that internal refactors can be
proven not to change what consuming apps render.

- A missing reference is recorded and the test fails once; re-run to compare.
- To re-record after an intentional visual change:
  `SIMCTL_CHILD_RECORD_SNAPSHOTS=1 xcodebuild test …`, then review the PNG diff in
  the commit.
- On failure, the rendered image is written to `__Snapshots__/.failures/` (ignored by
  git) for side-by-side inspection.
