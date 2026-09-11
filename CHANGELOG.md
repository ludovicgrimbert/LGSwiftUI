# Changelog

All notable changes to this package. The format follows [Keep a Changelog](https://keepachangelog.com);
the package uses [SemVer](https://semver.org) — while on `0.x`, minor versions may break source compatibility
and are called out below.

## [Unreleased]

### Added
- Snapshot tests (`ImageRenderer`-based, no external dependency) covering every public component in both
  colour schemes, plus unit tests locking the numeric tokens and the `Color` helpers.
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
