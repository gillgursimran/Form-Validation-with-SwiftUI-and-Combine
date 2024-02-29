//
//  OurTextField.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import SwiftUI
import Combine

public struct OurTextField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isValid: Bool
    @Binding var error: String?
    var isOptionalField: Bool
    let emptyMessage: String
    let trailingIcon: Icon?
    let trailingText: String
    let keyboardType: UIKeyboardType
    @State private var state: TextFieldState = .initial
    private let spacingBetween = 10.0
    private let errorOffset = 5.0
    var maxCharacterLength: Int?
    let colorTheme: TextFieldColorMode
    let textFieldType: TextFieldType
    let onBeginEditing: ((String) -> Void)?
    let onEndEditing: ((String) -> Void)?
    let onTextValueChanged: ((String) -> Void)?
    let iconTapAction: (() -> Void)?

    public init(
        placeholder: String? = "",
        text: Binding<String>,
        isValid: Binding<Bool> = Binding.constant(true),
        error: Binding<String?> = Binding.constant(nil),
        isOptionalField: Bool = false,
        emptyMessage: String = "",
        trailingIcon: Icon? = nil,
        trailingText: String = "",
        keyboardType: UIKeyboardType = .default,
        maxCharacterLength: Int? = nil,
        colorTheme: TextFieldColorMode = .vibrant,
        textFieldType: TextFieldType = .roundedRectangle,
        onBeginEditing: ((String) -> Void)? = nil,
        onEndEditing: ((String) -> Void)? = nil,
        onTextValueChanged: ((String) -> Void)? = nil,
        iconTapAction: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder ?? ""
        self._text = text
        self._isValid = isValid
        self._error = error
        self.isOptionalField = isOptionalField
        self.emptyMessage = emptyMessage
        self.trailingIcon = trailingIcon
        self.trailingText = trailingText
        self.keyboardType = keyboardType
        self.maxCharacterLength = maxCharacterLength
        self.colorTheme = colorTheme
        self.textFieldType = textFieldType
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onTextValueChanged = onTextValueChanged
        self.iconTapAction = iconTapAction
    }

    private var textColor: Color {
        switch state {
        case .initial: return Colors.primaryGrey
        case .editing: return Colors.primaryGrey
        case .filled: return Colors.primaryGrey
        case .error: return colorTheme == .vibrant ? Colors.red : Colors.primaryGrey
        case .empty: return colorTheme == .vibrant ? Colors.red : Colors.primaryGrey
        }
    }

    private var placeholderColor: Color {
        switch state {
        case .initial: return colorTheme == .vibrant ? Colors.appFooterGrey : Colors.appFooterGrey
        case .editing: return Colors.appFooterGrey
        case .filled: return Colors.appFooterGrey
        case .error: return colorTheme == .vibrant ? Colors.red : Colors.appFooterGrey
        case .empty: return colorTheme == .vibrant ? Colors.red : Colors.appFooterGrey
        }
    }

    private var borderColor: Color {
        switch state {
        case .initial: return Colors.textFieldBackground
        case .editing: return Colors.textFieldBackground
        case .filled: return Colors.textFieldBackground
        case .error: return colorTheme == .vibrant ? Colors.red : Colors.textFieldBackground
        case .empty: return colorTheme == .vibrant ? Colors.red : Colors.textFieldBackground
        }
    }

    public var body: some View {
        VStack {
            HStack {
                ZStack {
                    placeHolderView()
                    textFieldView()
                }
                trailingView()
            }
            .modifyIf(textFieldType == .roundedRectangle) { textFieldView in
                textFieldView
                    .padding()
                    .addRoundedBackgroundColor(Colors.white)
                    .addRoundRectBorderOverlay(borderColor, borderWidth: 1.0, cornerRadius: Dimens.cardCornerRadius)
            }
            .modifyIf(textFieldType == .square) { textFieldView in
                textFieldView
                    .padding()
                    .addRoundedBackgroundColor(Colors.white, cornerRadius: 0)
                    .addRoundRectBorderOverlay(borderColor, borderWidth: 1.0, cornerRadius: 0)
            }

            if state == .error || state == .empty {
                errorView()
            }
        }
        .frame(
            height: (state == .error || state == .empty)
               ? Dimens.defaultTextFieldHeight + Dimens.textFieldErrorViewHeight
               : Dimens.defaultTextFieldHeight
        )
        .animation(.default, value: text)
        .onReceive(Just(error)) { _ in
            if state != .editing {
                action(.checkError)
            }
        }
    }

    private func placeHolderView() -> some View {
        Text(placeholder)
            .customText(size: Dimens.defaultLabelSize, color: placeholderColor)
            .offset(y: textFieldType == .plain || $text.wrappedValue.isEmpty ? 0 : -spacingBetween)
            .opacity(textFieldType == .plain && !$text.wrappedValue.isEmpty ? 0 : 1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func textFieldView() -> some View {
        HStack {
            OurTextFieldBase(
                placeholder: "",
                text: $text,
                keyboardType: keyboardType,
                maxCharacterLength: maxCharacterLength,
                onBeginEditing: { text in
                    action(.isEditing)
                    onBeginEditing?(text)
                },
                onEndEditing: { text in
                    action(.isFinished)
                    onEndEditing?(text)
                },
                onTextValueChanged: { text in
                    onTextValueChanged?(text)
                }
            )
            .customText(size: Dimens.defaultTextSize, color: textColor)
            .offset(y: textFieldType == .plain || $text.wrappedValue.isEmpty ? 0 : spacingBetween)
        }
    }

    private func trailingView() -> some View {
        HStack {
            if !trailingText.isEmpty {
                OurText(trailingText, size: Dimens.defaultLabelSize, color: Colors.appFooterGrey)
            }

            if let icon = trailingIcon, isValid {
                icon
                    .animation(.default, value: isValid)
                    .onTap {
                        iconTapAction?()
                    }
            }
        }
        .frame(height: .zero)
    }

    private func errorView() -> some View {
        Text(state == .empty ? emptyMessage : error ?? "")
            .customText(size: Dimens.defaultLabelSize, color: isOptionalField ? Colors.orange : Colors.red)
            .opacity(state == .empty || state == .error ? 1 : 0)
            .offset(y: state == .empty || state == .error ? 0 : errorOffset)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.default, value: error)
    }

    func setState(_ state: TextFieldState) {
        switch state {
        case .initial:
            self.state = .initial
        case .editing:
            self.state = .editing
        case .filled:
            self.state = .filled
        case .error:
            self.state = .error
        case .empty:
            self.state = .empty
        }
    }

    func action(_ action: TextFieldAction) {
        switch action {
        case .isEditing:
            setState(.editing)
        case .isFinished:
            if text.isEmpty {
                setState(.empty)
            } else {
                setState(.filled)
            }
        case .checkError:
            if error != nil {
                setState(.error)
            } else if isValid == true {
                setState(.filled)
            }
        }
    }
}

extension OurTextField {
    enum TextFieldState {
        case initial
        case editing
        case filled
        case error
        case empty
    }

    enum TextFieldAction {
        case isEditing
        case isFinished
        case checkError
    }

    public enum TextFieldColorMode {
        case light
        case vibrant
    }

    public enum TextFieldType {
        case plain
        case roundedRectangle
        case square
    }
}

private struct OurTextFieldBase: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType
    var showDoneButton: Bool
    var textColor: Color
    var textSize: CGFloat
    var fontName: String
    var maxCharacterLength: Int?
    var autoCorrectType: UITextAutocorrectionType
    var onBeginEditing: ((String) -> Void)?
    var onEndEditing: ((String) -> Void)?
    var onTextValueChanged: ((String) -> Void)?

    public init(
        placeholder: String = "",
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        textColor: Color = Colors.primaryGrey,
        textSize: CGFloat = Dimens.defaultTextSize,
        fontName: String = "Inter-Regular",
        showDoneButton: Bool = true,
        maxCharacterLength: Int? = nil,
        autoCorrectType: UITextAutocorrectionType = .no,
        onBeginEditing: ((String) -> Void)? = nil,
        onEndEditing: ((String) -> Void)? = nil,
        onTextValueChanged: ((String) -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.textColor = textColor
        self.textSize = textSize
        self.fontName = fontName
        self.showDoneButton = showDoneButton
        self.maxCharacterLength = maxCharacterLength
        self.autoCorrectType = autoCorrectType
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onTextValueChanged = onTextValueChanged
    }

    public typealias UIViewType = UITextField

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = keyboardType
        textField.delegate = context.coordinator
        textField.font = UIFont(name: fontName, size: textSize)
        textField.textColor = UIColor(textColor)
        textField.placeholder = placeholder
        textField.autocorrectionType = autoCorrectType
        textField.text = text
        textField.tintColor = UIColor(Colors.cursorColor)

        // Prevents the text field's width from expanding (and affecting SwiftUI containers) when the input text is
        // long.
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        if showDoneButton {
            textField.addDoneButtonOnKeyboard()
        }

        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        if !text.isEmpty || uiView.textColor == UIColor(textColor) {
            uiView.text = text
            uiView.textColor = UIColor(textColor)
        }
        uiView.delegate = context.coordinator
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: OurTextFieldBase

        init(_ textField: OurTextFieldBase) {
            self.parent = textField
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            if let onBeginEditing = parent.onBeginEditing {
                textField.text = parent.text
                onBeginEditing(textField.text ?? "")
            }
        }

        public func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return parent.maxCharacterLength == nil || newString.count <= parent.maxCharacterLength!
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
            if let onTextValueChanged = parent.onTextValueChanged {
                onTextValueChanged(textField.text ?? "")
            }
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            parent.text = textField.text ?? ""
            if let onEndEditing = parent.onEndEditing {
                onEndEditing(parent.text)
            }
        }
    }
}

extension UITextField {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect.init(
                x: 0,
                y: 0,
                width: UIScreen.width,
                height: Dimens.defaultKeyboardToolBarHeight
            )
        )
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
