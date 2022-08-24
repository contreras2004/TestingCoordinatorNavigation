//
//  LoginViewModel.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import Combine
import Foundation
import Navigation
import SwiftUI
import UI

public class LoginViewModel: BaseViewModel {
    @Published var user: String = "11111111-1"
    @Published var pass: String = "1"
    @Published var isPresentingError = false
    @Published var isLoading = false
    @Published var userModel: LoginResponseModel?
    @Published var apiError: LoginError = .unknown

    let userPlaceHolder: String = "User"
    let passPlaceHolder: String = "Pass"

    var service: LoginServiceProtocol = LoginService()

    override public var title: String { L10n.login }
    override public var navigationTitleColor: Color { .white }
    override public var navigationButtonIcon: String? { "info.circle" }
    override public var navigationButtonIconColor: Color { .white }
    override public var actionForNavigationButton: (() -> Void) {
        {
            let viewModel = InfoViewModel(coordinator: self.coordinator)
            self.coordinator.handle(event: LoginEvents.showModal(viewModel: viewModel))
        }
    }

    var isButtonDisabled: Bool {
        user.isEmpty && pass.isEmpty
    }

    func login() {
        isLoading = true

        let requestModel = LoginRequestModel(userName: user, password: pass)
        service.login(requestModel: requestModel) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let model):
                self?.userModel = model
                self?.coordinator.handle(event: LoginEvents.login)
            case .failure(let error):
                self?.apiError = error
                self?.isPresentingError = true
            }
        }
        /*Task {
            let requestModel = LoginRequestModel(userName: user, password: pass)
            let result = await service.login(requestModel: requestModel)
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                switch result {
                case .success(let model):
                    self?.userModel = model
                    self?.coordinator.handle(event: LoginEvents.login)
                case .failure(let error):
                    debugPrint("error: \(error)")
                    debugPrint(self)
                    self?.apiError = error
                    self?.isPresentingError = true
                    debugPrint("Is presenting error: \(self?.isPresentingError)")
                }
            }
        }*/

        // Example of canceling a request for any reason.
        // Enter the password = 3 to cancel after 3 seconds
        /*if pass == "3" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                debugPrint("vamos a cancelar el request")
                task.cancel()
            }
        }*/
    }
}
