//
//  FormView.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import SwiftUI

struct FormView: View {
    @StateObject var viewModel: FormViewModel = FormViewModel()

    var body: some View {
        CustomNavigationView {
            GeometryReader { geometry in
                VStack(spacing: Dimens.spacingMedium) {
                    Spacer()
                    Icon("Logo", bundle: SwiftUITextField.bundle, renderingMode: .original)
                    Spacer()
                    
                    VStack(spacing: Dimens.spacingMedium) {
                        OurTextField(
                            placeholder: Strings.placeholderFirstName,
                            text: $viewModel.firstName,
                            isValid: $viewModel.isValidFirstName,
                            error: $viewModel.firstNameError,
                            emptyMessage: Strings.requiredField,
                            keyboardType: .asciiCapable,
                            textFieldType: .square
                        )
                        
                        OurTextField(
                            placeholder: Strings.placeholderLastName,
                            text: $viewModel.lastName,
                            isValid: $viewModel.isValidLastName,
                            error: $viewModel.lastNameError,
                            emptyMessage: Strings.requiredField,
                            keyboardType: .asciiCapable,
                            textFieldType: .square
                        )
                        
                        OurTextField(
                            placeholder: Strings.placeholderEmail,
                            text: $viewModel.email,
                            isValid: $viewModel.isValidEmail,
                            error: $viewModel.emailError,
                            emptyMessage: Strings.requiredField,
                            keyboardType: .asciiCapable,
                            textFieldType: .square
                        )
                                                
                        OurTextField(
                            placeholder: Strings.placeholderPassword,
                            text: $viewModel.password,
                            isValid: $viewModel.isValidPaassword,
                            error: $viewModel.passwordError,
                            emptyMessage: Strings.requiredField,
                            keyboardType: .asciiCapable,
                            textFieldType: .square
                        )
                    }
                    
                    FilledButton(
                        Strings.register,
                        backgroundColor: Colors.primaryBlue,
                        foregroundColor: Colors.white,
                        titleSize: Dimens.defaultTitleSize
                    ) {
                        viewModel.signUp()
                    }
                    .padding(.top, Dimens.spacingLarge)
                    .setDisabled(!viewModel.formIsValid)
                }
                .padding()
            }
        }
    }
}

#Preview {
    FormView()
}
