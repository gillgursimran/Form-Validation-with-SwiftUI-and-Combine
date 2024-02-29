//
//  Strings.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import Foundation

public struct Strings {
//    static let appName = "app_name".localized(SwiftUITextField.bundle)
//    static let changePassword = "change_password".localized(SwiftUITextField.bundle)
//    static let changePasswordConfirmation = "change_password_confirmation".localized(SwiftUITextField.bundle)
//    static let errorChangingPassword = "error_changing_password".localized(SwiftUITextField.bundle)
//    static let okay = "okay".localized(SwiftUITextField.bundle)
    static let signin = "signin".localized(SwiftUITextField.bundle)
//    static let signinCap = "signin_cap".localized(SwiftUITextField.bundle)
    static let register = "register".localized(SwiftUITextField.bundle)
//    static let signinWithApple = "signin_with_apple".localized(SwiftUITextField.bundle)
//    static let signinAsDriver = "signin_as_driver".localized(SwiftUITextField.bundle)
//    static let signinAsOwner = "signin_as_owner".localized(SwiftUITextField.bundle)
//    static let resetPassword = "reset_password".localized(SwiftUITextField.bundle)
//
    static let placeholderFirstName = "placeholder_first_name".localized(SwiftUITextField.bundle)
    static let placeholderLastName = "placeholder_last_name".localized(SwiftUITextField.bundle)
    static let placeholderEmail = "placeholder_email".localized(SwiftUITextField.bundle)
    static let placeholderPassword = "placeholder_password".localized(SwiftUITextField.bundle)
    static let requiredField = "required_field".localized(SwiftUITextField.bundle)
//    static let forgotPasswordHeader = "forgot_password_header".localized(SwiftUITextField.bundle)
    static let errorFirstNameLength = "error_first_name_length".localized(SwiftUITextField.bundle)
    static let errorLastNameLength = "error_last_name_length".localized(SwiftUITextField.bundle)
    static let errorEmail = "error_email".localized(SwiftUITextField.bundle)
    static let errorPassword = "error_password".localized(SwiftUITextField.bundle)

}

public extension String {
    func localized(_ bundle: Bundle, tableName: String = "Localizable") -> String {
        return NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: "\(self)",
            comment: ""
        )
    }
}

public class StringUtils {
    public static func emailPredicate() -> NSPredicate {
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
}
