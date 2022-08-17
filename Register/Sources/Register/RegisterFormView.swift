//
//  Form.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import Navigation
import SwiftUI
import Theme
import UI

public struct RegisterFormView: View {
    @ObservedObject var viewModel: RegisterFormViewModel

    public init(viewModel: RegisterFormViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Spacer().frame(height: 100)
            DefaultTextField(
                placeholder: viewModel.namePlaceHolder,
                value: $viewModel.userName)

            DefaultTextField(
                placeholder: viewModel.emailPlaceHolder,
                value: $viewModel.email,
                errorMessage: $viewModel.emailError)

            DefaultTextField(placeholder: viewModel.passPlaceHolder, isSecure: true, value: $viewModel.password)

            DefaultTextField(
                placeholder: viewModel.passPlaceHolder,
                isSecure: true,
                value: $viewModel.repeatPassword,
                errorMessage: $viewModel.passwordsDontMatchError)

            Toggle(isOn: $viewModel.acceptedTC) {
                Text(L10n.acceptTC)
            }.tint(ThemeColor.primaryAccent.swiftUIColor)

            Spacer()

            DefaultButton(
                text: L10n.registerTitle,
                isDisabled: $viewModel.formIsDisabled,
                isLoading: $viewModel.isLoading,
                action: {
                    viewModel.register()
                })
        }
        .padding()
        .alert(viewModel.state.alertTitle,
               isPresented: $viewModel.isPresentingAlert,
               presenting: RegisterError.self,
               actions: { _ in
            Button(L10n.errorAcceptButton, role: .cancel) { }
        }, message: { _ in
            Text(viewModel.state.alertMessage)
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFormView(viewModel: RegisterFormViewModel(coordinator: NavigationCoordinator()))
    }
}

/*private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}*/
