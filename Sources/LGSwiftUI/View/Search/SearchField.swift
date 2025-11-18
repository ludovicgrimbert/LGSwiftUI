//
//  SearchField.swift
//  LGSwiftUI
//
//  Created by Ludovic Grimbert on 10/11/2025.
//
import SwiftUI

public struct SearchField: View {
    public var placeholderColor: Color
    public var placeholderFont: Font
    public var textColor: Color
    public var textFont: Font

    public var keyboardType: UIKeyboardType
    public var submitLabel: SubmitLabel
    public var placeholderLabel: String
    public var triggerValue: Int
    public var dynamicTypeSize: ClosedRange<DynamicTypeSize>
    public var isAutocorrectionDisabled: Bool
    @Binding public var text: String
    @Binding public var isDisabled: Bool
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
        isDisabled: Binding<Bool> = .constant(false),
        searchButtonTapped: ((String) -> Void)? = nil,
        automaticSearchTrigger: ((String) -> Void)? = nil,
    ) {
        self.placeholderColor = placeholderColor
        self.placeholderFont = placeholderFont
        self.textColor = textColor
        self.textFont = textFont
        self.keyboardType = keyboardType
        self.isAutocorrectionDisabled = isAutocorrectionDisabled
        self.submitLabel = submitLabel
        self.triggerValue = triggerValue
        self.dynamicTypeSize = dynamicTypeSize
        self.placeholderLabel = placeholderLabel
        self._text = text
        self._isDisabled = isDisabled
        self.searchButtonTapped = searchButtonTapped
        self.automaticSearchTrigger = automaticSearchTrigger
    }
    
    public var body: some View {
        TextField(
            "",
            text: _text,
            prompt: Text(verbatim: placeholderLabel)
                .foregroundColor(placeholderColor)
                .font(placeholderFont)
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
            if text.count < triggerValue {
                searchButtonTapped?(text)
            }
            isTextFieldFocused = false
        }
        .submitLabel(submitLabel)
        .disabled(isDisabled)
        .textFieldStyle(
            CustomTextFieldStyle(
                color: textColor,
                font: textFont
            )
        )
    }
}
