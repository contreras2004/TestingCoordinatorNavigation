//
//  RegisterFormViewModel.swift
//  
//
//  Created by m.contreras.selman on 09-08-22.
//

import Navigation
import SwiftUI

public class RegisterFormViewModel: BaseViewModel {
    enum ViewState {
        case waitingForSubmit
        case waitingForResponse
        case finishedWithSuccess
        case finishedWithError(error: RegisterError)

        var alertTitle: String {
            switch self {
            case .finishedWithSuccess, .waitingForSubmit, .waitingForResponse:
                return L10n.welcome
            case .finishedWithError(error: let error):
                return error.title
            }
        }

        var alertMessage: String {
            switch self {
            case .finishedWithSuccess, .waitingForSubmit, .waitingForResponse:
                return L10n.welcomeMessage
            case .finishedWithError(error: let error):
                return error.message
            }
        }
    }

    override public var title: String { L10n.registerTitle }

    let namePlaceHolder: String = L10n.name
    let emailPlaceHolder: String = L10n.email
    let passPlaceHolder: String = L10n.passPlaceholder
    var service: RegisterServiceProtocol = RegisterService()

    @Published var userName: String = "" { didSet { checkButtonEnabled() } }
    @Published var email: String = "" { didSet { checkButtonEnabled() } }
    @Published var password: String = "" { didSet { checkButtonEnabled() } }
    @Published var repeatPassword: String = "" { didSet { checkButtonEnabled() } }
    @Published var acceptedTC = false { didSet { checkButtonEnabled() } }
    @Published var isLoading = false
    @Published var formIsDisabled = true
    @Published var emailError: String = ""
    @Published var passwordsDontMatchError: String = ""
    @Published var isPresentingAlert = false

    @Published var state: ViewState = .waitingForSubmit {
        didSet {
            switch state {
            case .waitingForSubmit:
                self.isLoading = false
            case .finishedWithSuccess, .finishedWithError:
                self.isPresentingAlert = true
                self.isLoading = false
            case .waitingForResponse:
                self.isLoading = true
            }
        }
    }

    func register() {
        if formIsValid() == false { return }
        self.state = .waitingForResponse
        let model = RegisterRequestModel(userName: userName, email: email, pass: password)
        Task {
            let response = await service.register(requestModel: model)
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success:
                    self?.coordinator.handle(event: RegisterEvent.goToRoot)
                    self?.state = .finishedWithSuccess
                case .failure(let error):
                    self?.state = .finishedWithError(error: error)
                }
            }
        }
    }

    deinit {
        debugPrint("\(self) has been deinitialized")
    }

    private func formIsValid() -> Bool {
        if !isValid(email: email) {
            emailError = "Email no es válido"
            formIsDisabled = true
            return false
        } else {
            emailError = ""
        }
        if password != repeatPassword {
            passwordsDontMatchError = "Las contraseñas no coinciden"
            formIsDisabled = true
            return false
        } else {
            passwordsDontMatchError = ""
        }
        return true
    }

    private func checkButtonEnabled() {
        self.formIsDisabled = (
            userName.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            repeatPassword.isEmpty ||
            !acceptedTC
        )
    }

    private func isValid(email: String) -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])" //swiftlint:disable:this line_length
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}
