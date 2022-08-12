//
//  Welcome.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import Navigation
import SwiftUI
import Theme
import UI

public struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        viewModel.setNavigationBarColor(color: .white)
    }

    public var body: some View {
        VStack {
            Spacer().frame(height: 100)
            Image(systemName: "swift")
                .resizable()
                .foregroundColor(.red)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 150)

            Spacer()
            DefaultTextField(placeholder: viewModel.userPlaceHolder, value: $viewModel.user)
            DefaultTextField(placeholder: viewModel.passPlaceHolder, value: $viewModel.pass)
            Spacer()
            DefaultButton(text: L10n.login, isLoading: $viewModel.isLoading, action: {
                viewModel.login()
            })
            DefaultButton(text: L10n.register, style: .onlyText, action: {
                viewModel.coordinator.handle(event: LoginEvents.goToRegisterForm)
            })
        }
        .padding()
        .withAnimatedBackground()
        .navigationBarTitle(L10n.login, displayMode: .inline)
        .alert(viewModel.apiError.title,
               isPresented: $viewModel.isPresentingError,
               presenting: LoginError.self,
               actions: { _ in
            if viewModel.apiError == .nonExistingUser {
                Button(L10n.errorCreateAccountButton, role: .none) {
                    self.viewModel.coordinator.handle(event: LoginEvents.goToRegisterForm)
                }
            }
            Button(L10n.errorAcceptButton, role: .cancel) { }
        }, message: { _ in
            Text(viewModel.apiError.message)
        })
        .onDisappear {
            viewModel.setNavigationBarColor(color: .black)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
