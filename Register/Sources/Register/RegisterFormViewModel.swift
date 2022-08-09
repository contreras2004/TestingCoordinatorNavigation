//
//  RegisterFormViewModel.swift
//  
//
//  Created by m.contreras.selman on 09-08-22.
//

import Navigation
import SwiftUI

public class RegisterFormViewModel: BaseViewModel {
    override public var title: String { L10n.registerTitle }

    let namePlaceHolder: String = L10n.name
    let emailPlaceHolder: String = L10n.email
    let passPlaceHolder: String = L10n.passPlaceholder

    @Published var userName: String = "" { didSet { checkFormStatus() } }
    @Published var email: String = "" { didSet { checkFormStatus() } }
    @Published var password: String = "" { didSet { checkFormStatus() } }
    @Published var repeatPassword: String = "" { didSet { checkFormStatus() } }
    @Published var acceptedTC = false { didSet { checkFormStatus() } }
    @Published var isLoading = false
    @Published var formIsDisabled = true

    func register() {
        debugPrint("register")
    }

    private func checkFormStatus() {
        self.formIsDisabled = (
            userName.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            repeatPassword.isEmpty ||
            !acceptedTC
        )
    }
}
