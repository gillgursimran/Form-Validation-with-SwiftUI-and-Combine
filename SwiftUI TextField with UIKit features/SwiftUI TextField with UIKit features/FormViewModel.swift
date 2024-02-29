//
//  FormViewModel.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import Foundation
import Combine

class FormViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var isValidFirstName: Bool = false
    @Published var firstNameError: String?

    @Published var lastName: String = ""
    @Published var isValidLastName: Bool = false
    @Published var lastNameError: String?

    @Published var email: String = ""
    @Published var isValidEmail: Bool = false
    @Published var emailError: String?

    @Published var password: String = ""
    @Published var isValidPaassword: Bool = false
    @Published var passwordError: String?
    
    // Output subscribers
    @Published var formIsValid = false
      
    private var publishers = Set<AnyCancellable>()
      
    init() {
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
    
    func signUp() {
        print("User registered")
    }
}

private extension FormViewModel {
    var isValidFirstNamePublisher: AnyPublisher<Bool, Never> {
        $firstName
            .map { firstName in
                if firstName.count < 4 {
                    self.firstNameError = firstName.isEmpty ? nil : Strings.errorFirstNameLength
                    return false
                }
                self.firstNameError = nil
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var isValidLastNamePublisher: AnyPublisher<Bool, Never> {
        $lastName
            .map { lastName in
                if lastName.count < 3 {
                    self.lastNameError = lastName.isEmpty ? nil : Strings.errorLastNameLength
                    return false
                }
                self.lastNameError = nil
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                if !StringUtils.emailPredicate().evaluate(with: email) {
                    self.emailError = email.isEmpty ? nil : Strings.errorEmail
                    return false
                }
                self.emailError = nil
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                if password.count < 6 {
                    self.passwordError = password.isEmpty ? nil : Strings.errorPassword
                    return false
                }
                self.passwordError = nil
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest4(
                isValidFirstNamePublisher,
                isValidLastNamePublisher,
                isValidEmailPublisher,
                isValidPasswordPublisher
            )
            .map { isFirstNameValid, isLastNameValid, isEmailValid, isPasswordValid in
                return isFirstNameValid && isLastNameValid && isEmailValid && isPasswordValid
            }
            .eraseToAnyPublisher()
      }
}
