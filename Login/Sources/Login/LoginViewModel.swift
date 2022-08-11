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

    let userPlaceHolder: String = "User"
    let passPlaceHolder: String = "Pass"

    @Published var isPresentingError = false
    @Published var isLoading = false

    var service: LoginServiceProtocol = LoginService()

    @Published var userModel: LoginResponseModel?
    @Published var apiError: LoginError = .unknown

    override public var navigationButtonIcon: String? { "info.circle" }

    override public var actionForNavigationButton: (() -> Void) {
        {
            self.coordinator.viewModelForModal = InfoViewModel(coordinator: self.coordinator)
            self.coordinator.handle(event: LoginEvents.showModal)
        }
    }

    var isButtonDisabled: Bool {
        user.isEmpty && pass.isEmpty
    }

    func login() {
        self.isLoading = true
        let requestModel = LoginRequestModel(userName: user, password: pass)
        service.login(requestModel: requestModel) { [weak self] response in
            self?.isLoading = false
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.userModel = model
                    self?.coordinator.handle(event: LoginEvents.login)
                }
            case .failure(let error):
                self?.apiError = error
                self?.isPresentingError = true
            }
        }

        // Example of canceling a request for any reason.
        // Enter the password = 3 to cancel after 3 seconds
        if pass == "3" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                debugPrint("vamos a cancelar el request")
                self?.service.cancelables.first?.cancel()
                self?.isLoading = false
            }
        }

        /*service.login(requestModel: requestModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("finished: \(completion)")
                case .failure(let error):
                    debugPrint("failure: \(error), typeOf: \(type(of: error))")
                    self?.isPresentingError = true
                }
            } receiveValue: { [weak self] userModel in
                self?.userModel = userModel
                DispatchQueue.main.async {
                    self?.coordinator?.login()
                }
            }.store(in: &cancelables)
        */
        /*service.execute(
             endpoint: .login,
             decodingType: LoginResponseModel.self,
             httpMethod: .post,
             params: requestModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("finished: \(completion)")
                case .failure(let error):
                    debugPrint("failure: \(error), typeOf: \(type(of: error))")
                    self?.isPresentingError = true
                }
            } receiveValue: { [weak self] userModel in
                self?.userModel = userModel
                DispatchQueue.main.async {
                    self?.coordinator?.login()
                }
            }.store(in: &cancelables)*/
    }
}
