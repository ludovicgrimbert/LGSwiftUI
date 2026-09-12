# Changelog

All notable changes to this package. The format follows [Keep a Changelog](https://keepachangelog.com);
the package uses [SemVer](https://semver.org) — while on `0.x`, minor versions may break source compatibility
and are called out below.

## [0.4.1] - 2026-09-12

### Fixed
- `PrimaryButtonStyle`'s border rendered as 4 disconnected segments (2 short horizontal ones
  poking past the capsule's silhouette, 2 barely-visible vertical slivers) instead of
  following the capsule outline — spotted in the example gallery. `.border(_:width:)` stroked
  a plain rectangle *before* `.clipShape(RoundedRectangle)` cut it down to a capsule, chopping
  the rectangle's corners instead of the stroke following the curve. Now clips and strokes the
  same shape. Neither RemoteTV nor Pampuko use this style, so they are unaffected.

## [0.4.0] - 2026-09-11

### Added
- `LGSwiftUI.xcworkspace` (package + example) and `Example/LGSwiftUIExample`, an xcodegen-generated
  gallery app showing every token, text role, button style and component, with colour-scheme and
  Dynamic Type switches. Depends on the library by local path.

### Changed
- Documentation: a forced `colorScheme` passed to `lgTheme(_:colorScheme:)` does not cross a sheet
  boundary; re-apply it on sheet content or use `preferredColorScheme`.

## [0.3.0] - 2026-09-11

### Added
- **Semantic layout tokens**: `theme.spacing` (`xs/s/m/l/xl` = 8/16/24/32/48), `theme.size`
  (`xxs/xs/s/m/l/xl` = 8/16/24/48/80/160) and `theme.radius` (`s/m` = 8/24) as
  `ThemeSpacing`/`ThemeSize`/`ThemeRadius` groups.
  Values are the historical ones; the flat `smallValue`/`smallMargin`/… tokens are now deprecated aliases
  derived from the groups, so an app that overrides `size` keeps both names consistent while migrating.
- **Dynamic Type**: `TextRole` (`h1`…`overline`, with base size, weight and the system text style each
  follows), `View.textStyle(_ role:)` / `LGTextStyle` (font + theme text colour) and `View.lgFont(_ role:)`
  (font only). Sizes scale with the user's text setting via `@ScaledMetric`; at the default setting they
  are exactly the historical fixed sizes (snapshots unchanged). `EnvironmentValues.lgScaledSize` exposes
  `theme.size` scaled the same way for control heights and icon sizes; the library's button styles use
  it, so buttons grow with their label instead of truncating it.
- `View.lgBackground(_ level:)` / `LGBackgroundModifier` (`.primary`/`.secondary`), replacing the
  `backgroundStyle(BackgroundPrimaryStyle())` composition.
- `View.neumorphic(_:effect:color:width:height:…)` / `NeumorphicModifier`: draws a `NeumorphismView`
  behind any content, sized to the content or to an explicit frame. Pixel-identical to the
  `ZStack { NeumorphismView(width:height:); content }` composition apps wrote by hand (proven by test).
- `NeumorphicButtonStyle`: text button on a neumorphic shape (theme defaults: `radius.m`, `lowShadow`,
  scaled `size.m` height, `.h5` role). Replaces the hand-written `NeuButtonView` helpers.
- `NeumorphismEffect` (`highShadow`, `highDeep`, `lowShadow`): the three treatments as an enum, so the
  never-rendering (`.low`, `.deep`) pair is no longer expressible. `NeumorphismView.init(style:effect:…)`
  and `NeumorphismStyle.shape`.
- `View.lgTheme(_:colorScheme:)` injects the theme (and optionally forces the colour scheme the styles
  read) and `View.lgPrimaryBackground()` fills the screen with the primary background — the glue both
  apps duplicated as `themeStyle`/`ForceTheme`/`ExtraTheme`.
- `ShapeHighDeep.deepStrokeDarkColor` / `deepStrokeLightColor` parameters (defaults `.gray`/`.white`,
  previously hardcoded); `width`/`height` optional on the three shape views.
- Snapshot tests (`ImageRenderer`-based, no external dependency) covering every public component in both
  colour schemes, equivalence tests proving new APIs render like the compositions they replace, plus unit
  tests locking the numeric tokens and the `Color` helpers.
- `View.lgTextFieldStyle(color:font:…)` and `lgTextFieldStyle(color:role:…)` (Dynamic Type-scaled font) with
  `LGTextFieldModifier`, a public-API replacement for `CustomTextFieldStyle`.
- `README.md` documenting the theme, the `Color(red:green:blue:)` 0-255 gotcha, and the test workflow.

### Changed
- `Theme` defaults are now the system's semantic colours (`systemBackground`, `label`, `systemGray4`…)
  instead of `Color.green` placeholders, so a view rendered without an injected theme, or an app that
  only overrides its `dark*` colours, gets a sensible appearance. Apps that override the colours they
  use (Pampuko, RemoteTV) are unaffected.
- `DefaultTheme` no longer duplicates every token; it relies on the protocol defaults.
- `UserInputField` gains an `init(placeholderColor:textColor:role:…)` whose fonts scale with Dynamic Type;
  `placeholderFont`/`textFont` become optional (`nil` with the role initializer). It uses `lgTextFieldStyle`
  internally (same rendering).
- `BottomSheetView` uses `NeumorphicButtonStyle` and `lgPrimaryBackground()` internally, and
  `CustomIconLabelStyle` now picks its icon colour from the current colour scheme. Both used to hardcode
  the `dark*` side of the theme: identical in dark mode (the only mode the apps ship), fixed in light mode.
- `NeumorphismView.getShape(style:)` deprecated in favour of `NeumorphismStyle.shape`.
- File headers corrected (`SwiftUIView.swift`, `File.swift` → actual file names).
- `CircleToggleButtonStyle` and `CircleStatusButtonStyle` compute their label colour once instead of
  duplicating the whole body per case; the three circle styles share one implementation. `PrimaryGradient`
  (the ring around circle buttons) now uses the `light*` gradient pair in light mode instead of always the
  `dark*` one — identical in dark mode, fixed in light mode (`ButtonStyles-light` snapshot re-recorded).
- `NeumorphicButtonStyle` takes a `role: TextRole` (default `.h5`) instead of a `font: Font?`.

### Deprecated
- The flat numeric tokens `smallValue`…`veryLargeValue`, `smallMargin`…`veryLargeMargin`, `oneHundred`,
  `twoHundred` — see the new `spacing`/`size`/`radius` groups. Each message says which group to use.
- The environment fonts `\.h1`…`\.overline` and their `CaptionFont*Key` types: they hand out fixed-size
  fonts that ignore Dynamic Type. Use `.textStyle(.h5)` or `.lgFont(.h5)`.
- The 13 per-role modifiers `H1Style()`…`OverlineStyle()`: use `.textStyle(.h1)` etc. They are now thin
  wrappers over `LGTextStyle`, so existing call sites already scale with Dynamic Type.
- `Text.textStyle<Style: ViewModifier>(_:)` and `View.backgroundStyle<Style: ViewModifier>(_:)`: both are
  `View.modifier(_:)` under another name, and the latter shadows SwiftUI's own `backgroundStyle(_:)`.
- `BackgroundPrimaryStyle` / `BackgroundSecondaryStyle`: use `.lgBackground(.primary/.secondary)`.
- `CustomTextFieldStyle`: it can only be implemented through `TextFieldStyle`'s private `_body`
  extension point. Use `.lgTextFieldStyle(...)`.

### Removed
- **Breaking:** the library's own `AnyShape`. SwiftUI ships `AnyShape` since iOS 16 with the same
  initializer; the duplicate made the symbol ambiguous. Neither consuming app referenced it.
- `Theme/Notes.swift` (comment-only inventory) — superseded by the README.

## [0.2.3]

Last release before this changelog was introduced.
