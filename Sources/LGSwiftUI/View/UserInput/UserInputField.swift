//
//  UserInputField.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 10/11/2025.
//
import SwiftUI

/// A single-line text field with a styled placeholder, a search/submit callback and an
/// optional "automatic search" callback fired once the text reaches `triggerValue` characters.
///
/// Prefer the `role:` initializer: the placeholder and the text then share a ``TextRole``
/// whose size scales with Dynamic Type. The `placeholderFont:`/`textFont:` initializer keeps
/// fixed fonts.
public struct UserInputField: View {
    public var placeholderColor: Color
    /// Fixed placeholder font; `nil` when the field was created with a ``TextRole``.
    public var placeholderFont: Font?
    public var textColor: Color
    /// Fixed text font; `nil` when the field was created with a ``TextRole``.
    public var textFont: Font?
    /// The role used for both fonts, when created with the `role:` initializer.
    public var role: TextRole?
    @ScaledMetric private var roleSize: CGFloat

    public var keyboardType: UIKeyboardType
    public var submitLabel: SubmitLabel
    public var placeholderLabel: String
    public var triggerValue: Int
    public var dynamicTypeSize: ClosedRange<DynamicTypeSize>
    public var isAutocorrectionDisabled: Bool
    @Binding public var text: String
    /// Plain value: the field only reads it. Pass the state you already have.
    public var isDisabled: Bool
    @FocusState private var isTextFieldFocused: Bool

    // Callback
    public var searchButtonTapped: ((String) -> Void)?
    public var automaticSearchTrigger: ((String) -> Void)?

    public init(
        placeholderColor: Color,
        placeholderFont: Font,
        textColor: Color,
        textFont: Font,
        keyboardType: UIKeyboardType = .default,
        isAutocorrectionDisabled: Bool = true,
        submitLabel: SubmitLabel = .search,
        triggerValue: Int = 3,
        dynamicTypeSize: ClosedRange<DynamicTypeSize> = .small ... .accessibility3 ,
        placeholderLabel: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        searchButtonTapped: ((String) -> Void)? = nil,
        automaticSearchTrigger: ((String) -> Void)? = nil,
    ) {
        self.placeholderColor = placeholderColor
        self.placeholderFont = placeholderFont
        self.textColor = textColor
        self.textFont = textFont
        self.role = nil
        self._roleSize = ScaledMetric(wrappedValue: 0)
        self.keyboardType = keyboardType
        self.isAutocorrectionDisabled = isAutocorrectionDisabled
        self.submitLabel = submitLabel
        self.triggerValue = triggerValue
        self.dynamicTypeSize = dynamicTypeSize
        self.placeholderLabel = placeholderLabel
        self._text = text
        self.isDisabled = isDisabled
        self.searchButtonTapped = searchButtonTapped
        self.automaticSearchTrigger = automaticSearchTrigger
    }

    /// Placeholder and text share `role`'s font, scaled with Dynamic Type.
    public init(
        placeholderColor: Color,
        textColor: Color,
        role: TextRole,
        keyboardType: UIKeyboardType = .default,
        isAutocorrectionDisabled: Bool = true,
        submitLabel: SubmitLabel = .search,
        triggerValue: Int = 3,
        dynamicTypeSize: ClosedRange<DynamicTypeSize> = .small ... .accessibility3 ,
        placeholderLabel: String,
        text: Binding<String>,
        isDisabled: Bool = false,
        searchButtonTapped: ((String) -> Void)? = nil,
        automaticSearchTrigger: ((String) -> Void)? = nil,
    ) {
        self.placeholderColor = placeholderColor
        self.placeholderFont = nil
        self.textColor = textColor
        self.textFont = nil
        self.role = role
        self._roleSize = ScaledMetric(wrappedValue: role.size, relativeTo: role.relativeTo)
        self.keyboardType = keyboardType
        self.isAutocorrectionDisabled = isAutocorrectionDisabled
        self.submitLabel = submitLabel
        self.triggerValue = triggerValue
        self.dynamicTypeSize = dynamicTypeSize
        self.placeholderLabel = placeholderLabel
        self._text = text
        self.isDisabled = isDisabled
        self.searchButtonTapped = searchButtonTapped
        self.automaticSearchTrigger = automaticSearchTrigger
    }

    private var resolvedPlaceholderFont: Font {
        placeholderFont ?? role?.font(size: roleSize) ?? TextRole.body1.fixedFont
    }

    private var resolvedTextFont: Font {
        textFont ?? role?.font(size: roleSize) ?? TextRole.body1.fixedFont
    }

    public var body: some View {
        TextField(
            "",
            text: _text,
            prompt: Text(verbatim: placeholderLabel)
                .foregroundColor(placeholderColor)
                .font(resolvedPlaceholderFont)
        )
        .autocorrectionDisabled(isAutocorrectionDisabled)
        .focused($isTextFieldFocused)
        .keyboardType(keyboardType)
        .dynamicTypeSize(dynamicTypeSize)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onChange(of: text) {
            if text.count >= triggerValue {
                automaticSearchTrigger?(text)
            }
        }
        .onSubmit {
            searchButtonTapped?(text)
            isTextFieldFocused = false
        }
        .submitLabel(submitLabel)
        .disabled(isDisabled)
        .lgTextFieldStyle(color: textColor, font: resolvedTextFont)
    }
}
