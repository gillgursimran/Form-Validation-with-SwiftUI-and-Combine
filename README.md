![image](https://github.com/gillgursimran/Form-Validation-with-SwiftUI-and-Combine/assets/161746621/de62d323-f5fe-488a-9695-7a0c07f22697)

![Simulator Screenshot - iPhone 16 Pro - 2025-07-06 at 08 29 11](https://github.com/user-attachments/assets/3dcebd11-ce2e-4d83-8f51-c0e2147b27de)


This provides a reasonably flexible and useful SwiftUI wrapper around UITextField that provides more control over errors and invalid text.

Features

It provides the ability to:

Use of SwiftUI bindings to capture entered text and control the text field's first responder status.
Observe and react to the text field's input.
Set the text field's placeholder.
Support for enabling and disabling the text field using the SwiftUI .setDisabled view modifier.
Control over how and when text changes should be permitted.
Control over if the text field should begin or end editing.
Display text input errors and text field name. 

Installation

Just Drag OurTextField.Swift file from source code into any project you need to use.

Usage is Easy

struct ExampleView: View {
  @State var email: String = ""
  @State var isValidEmail: Bool = false
  @State var emailError: String = ""

  var body: some View {
    VStack {
      OurTextField(
          placeholder: Strings.placeholderEmail,
          text: $email,
          isValid: $isValidEmail,
          error: $emailError,
          emptyMessage: Strings.requiredField,
          keyboardType: .asciiCapable,
          textFieldType: .square
      )
    }
  }
}

Please refer to source code for more information about declared fields.
