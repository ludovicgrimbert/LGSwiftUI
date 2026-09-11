# Changelog

All notable changes to this package. The format follows [Keep a Changelog](https://keepachangelog.com);
the package uses [SemVer](https://semver.org) — while on `0.x`, minor versions may break source compatibility
and are called out below.

## [Unreleased]

### Added
- `View.neumorphic(_:effect:color:width:height:…)` / `NeumorphicModifier`: draws a `NeumorphismView`
  behind any content, sized to the content or to an explicit frame. Pixel-identical to the
  `ZStack { NeumorphismView(width:height:); content }` composition apps wrote by hand (proven by test).
- `NeumorphicButtonStyle`: text button on a neumorphic shape (theme defaults: `smallValue` radius,
  `lowShadow`, `mediumValue` height, `h5`). Replaces the hand-written `NeuButtonView` helpers.
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
- `View.lgTextFieldStyle(color:font:cornerRadius:strokeColor:lineWidth:)` and `LGTextFieldModifier`,
  a public-API replacement for `CustomTextFieldStyle`.
- `README.md` documenting the theme, the `Color(red:green:blue:)` 0-255 gotcha, and the test workflow.

### Changed
- `Theme` defaults are now the system's semantic colours (`systemBackground`, `label`, `systemGray4`…)
  instead of `Color.green` placeholders, so a view rendered without an injected theme, or an app that
  only overrides its `dark*` colours, gets a sensible appearance. Apps that override the colours they
  use (Pampuko, RemoteTV) are unaffected.
- `DefaultTheme` no longer duplicates every token; it relies on the protocol defaults.
- `UserInputField` uses `lgTextFieldStyle` internally (same rendering).
- `BottomSheetView` uses `NeumorphicButtonStyle` and `lgPrimaryBackground()` internally, and
  `CustomIconLabelStyle` now picks its icon colour from the current colour scheme. Both used to hardcode
  the `dark*` side of the theme: identical in dark mode (the only mode the apps ship), fixed in light mode.
- `NeumorphismView.getShape(style:)` deprecated in favour of `NeumorphismStyle.shape`.
- File headers corrected (`SwiftUIView.swift`, `File.swift` → actual file names).

### Deprecated
- `CustomTextFieldStyle`: it can only be implemented through `TextFieldStyle`'s private `_body`
  extension point. Use `.lgTextFieldStyle(...)`.

### Removed
- **Breaking:** the library's own `AnyShape`. SwiftUI ships `AnyShape` since iOS 16 with the same
  initializer; the duplicate made the symbol ambiguous. Neither consuming app referenced it.
- `Theme/Notes.swift` (comment-only inventory) — superseded by the README.

## [0.2.3]

Last release before this changelog was introduced.
