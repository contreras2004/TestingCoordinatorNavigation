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
            LargeButton(text: L10n.login, isLoading: $viewModel.isLoading, action: {
                viewModel.login()
            })
        }
        .padding()
        .navigationBarTitle(L10n.login, displayMode: .inline)
        .alert(viewModel.apiError.title,
               isPresented: $viewModel.isPresentingError,
               presenting: LoginError.self,
               actions: { _ in
            Button(L10n.errorAcceptButton, role: .cancel) { }
        }, message: { _ in
            Text(viewModel.apiError.message)
        })
    }
}

/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(coordinator: Coordinator(tabs: [], viewModels: [])))
    }
}*/

/*private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}*/
