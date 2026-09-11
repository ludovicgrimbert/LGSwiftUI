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
(system semantic colours, and the layout tokens below):

```swift
struct AppTheme: Theme {
    var darkPrimaryBackgroundColor: Color = Color(red: 30, green: 30, blue: 30)
    var darkTextColor: Color = .white
    var darkToggleColor: Color = .orange
    var size = ThemeSize(l: 120)          // keep the other sizes, widen `l`
}
```

Inject it once at the root:

```swift
RootView()
    .lgTheme(AppTheme(), colorScheme: .dark)   // colorScheme is optional
```

Every style reads `\.theme` and `\.colorScheme` from the environment and picks the
matching `light*`/`dark*` colour. `colorScheme:` forces the side the library's styles use
without touching system UI; use `.preferredColorScheme(_:)` at the scene root if you want
alerts and keyboards to follow too.

### Layout tokens

| Group | Tokens | Use for |
|---|---|---|
| `theme.spacing` | `xs` 8 · `s` 16 · `m` 24 · `l` 32 · `xl` 48 | padding, stack spacing, gaps |
| `theme.size` | `s` 24 · `m` 48 · `l` 80 · `xl` 160 | icon sizes, control heights, fixed widths |
| `theme.radius` | `s` 8 · `m` 24 | corner radii |

For dimensions that wrap text, read `@Environment(\.lgScaledSize)` instead of
`theme.size`: it is the same table multiplied by the user's Dynamic Type factor
(`1` at the default setting), so controls grow with their label instead of truncating it.

Prefer `.frame(minWidth:minHeight:)` over `.frame(width:height:)` around text — identical
at the default size, and the view can still grow when the text does.

### Typography

Thirteen `TextRole`s (`h1`…`h6`, `subtitle1/2`, `body1/2`, `caption`, `caption2`,
`overline`) with fixed base metrics that scale with Dynamic Type:

```swift
Text("Stations").textStyle(.h5)          // font + theme text colour
Image(systemName: "bell").lgFont(.caption)   // font only
```

### ⚠️ `Color(red:green:blue:opacity:)` takes 0-255

`LGSwiftUI` shadows SwiftUI's initializer of the same name. In any file that imports
`LGSwiftUI`, `Color(red: 30, green: 30, blue: 30)` means **30/255**, not a saturated
white. See `Extension/ExtColor.swift`. `Color(hex: 0x1E1E1E)` is also available.

## What's in the box

| Area | API |
|---|---|
| Theme | `Theme`, `ThemeSpacing`, `ThemeSize`, `ThemeRadius`, `View.lgTheme(_:colorScheme:)`, `\.lgScaledSize` |
| Typography | `TextRole`, `View.textStyle(_:)`, `View.lgFont(_:)` |
| Backgrounds | `View.lgBackground(.primary/.secondary)`, `View.lgPrimaryBackground()` (fills the screen) |
| Buttons | `SimpleButtonStyle`, `ClearButtonStyle`, `PrimaryButtonStyle`, `RectangleButtonStyle`, `CircleButtonStyle`, `CircleToggleButtonStyle`, `CircleStatusButtonStyle`, `NeumorphicButtonStyle` |
| Neumorphism | `View.neumorphic(_:effect:…)`, `NeumorphismView`, `NeumorphismStyle`, `NeumorphismEffect`, `Triangle` |
| Text fields | `View.lgTextFieldStyle(color:font:cornerRadius:strokeColor:lineWidth:)` |
| Labels | `CustomIconLabelStyle(color:size:)` |
| Components | `BottomSheetView`, `UserInputField`, `RotateButtonView`, `ScrollableContainerView`, `LoaderView` |
| Helpers | `View.overlayWithProxy(alignment:content:)`, `Color(hex:)` |

### Neumorphism

```swift
Text("Back").textStyle(.h5)
    .neumorphic(.roundedRectangle(cornerRadius: theme.radius.m), effect: .lowShadow,
                width: theme.size.l, height: theme.size.m)   // omit width/height to size to content

Button("Delete", action: delete)
    .buttonStyle(NeumorphicButtonStyle(width: 240))
```

## Migrating from 0.2.x

Everything from 0.2.x still compiles (except the library's own `AnyShape`, which SwiftUI
provides); deprecated symbols point to their replacement:

| 0.2.x | 0.3.0 |
|---|---|
| `theme.smallValue` (as a size) / (as a gap) / (as a radius) | `theme.size.s` / `theme.spacing.m` / `theme.radius.m` |
| `theme.mediumValue`, `largeValue`, `veryLargeValue` | `theme.size.m`, `.l`, `.xl` |
| `theme.smallMargin`, `mediumMargin`, `largeMargin`, `veryLargeMargin` | `theme.spacing.xs`, `.s`, `.m`, `.l` |
| `Text(…).textStyle(H5Style())` | `Text(…).textStyle(.h5)` |
| `@Environment(\.caption) var caption` + `.font(caption)` | `.lgFont(.caption)` |
| `.backgroundStyle(BackgroundPrimaryStyle())` | `.lgBackground(.primary)` |
| `ZStack { NeumorphismView(…, width:, height:); content }` | `content.neumorphic(…, width:, height:)` |
| `.textFieldStyle(CustomTextFieldStyle(…))` | `.lgTextFieldStyle(…)` |
| `.environment(\.theme, t).environment(\.colorScheme, .dark)` | `.lgTheme(t, colorScheme: .dark)` |

## Development

The package is iOS-only, so build and test through an iOS simulator:

```sh
xcodebuild test -scheme LGSwiftUI -destination 'platform=iOS Simulator,name=iPhone 17'
```

### Snapshot tests

`Tests/LGSwiftUITests/ComponentSnapshotTests.swift` renders every component with
`ImageRenderer` in both colour schemes (and at an accessibility Dynamic Type size) and
compares the pixels with the PNGs committed in `Tests/LGSwiftUITests/__Snapshots__/`.
`EquivalenceTests.swift` renders a new API and the composition it replaces side by side.
Together they prove that internal refactors do not change what consuming apps render.

- A missing reference is recorded and the test fails once; re-run to compare.
- To re-record after an intentional visual change:
  `SIMCTL_CHILD_RECORD_SNAPSHOTS=1 xcodebuild test …`, then review the PNG diff in
  the commit.
- On failure, the rendered image is written to `__Snapshots__/.failures/` (ignored by
  git) for side-by-side inspection.
