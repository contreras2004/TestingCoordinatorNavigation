//
//  LoginService.swift
//  Tolls
//
//  Created by m.contreras.selman on 21-07-22.
//

import Combine
import Foundation
import Networking

enum LoginError: Int64, Error {
    case nonExistingUser = 1
    case invalidPassword = 2
    case unknown

    var title: String {
        "L10n.errorTitle"
    }

    var message: String {
        switch self {
        case .nonExistingUser:
            return "L10n.loginErrorCode1"
        case .invalidPassword:
            return "L10n.loginErrorCode2"
        case .unknown:
            return "L10n.errorMessage"
        }
    }
}

protocol LoginServiceProtocol {
    var api: ApiProtocol { get }
    var cancelables: Set<AnyCancellable> { get }

    func login(requestModel: LoginRequestModel, completion: @escaping (Result<LoginResponseModel, LoginError>) -> Void)
}

public class LoginService: LoginServiceProtocol {
    var api: ApiProtocol = API()

    var cancelables = Set<AnyCancellable>()

    func login(
        requestModel: LoginRequestModel,
        completion: @escaping (Result<LoginResponseModel, LoginError>) -> Void) {
        api.execute(endpoint: .login, decodingType: LoginResponseModel.self, httpMethod: .post, params: requestModel)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    switch error {
                    case .validationError(let error):
                        completion(.failure(LoginError(rawValue: error.errorCode) ?? .unknown))
                    default:
                        completion(.failure(LoginError.unknown))
                    }
                case .finished:
                    break
                }
            } receiveValue: { userModel in
                DispatchQueue.main.async {
                    completion(.success(userModel))
                }
            }.store(in: &cancelables)
    }

    /* Another way of writing the same function
    func login(requestModel: LoginRequestModel) {
        api.execute(endpoint: .login, decodingType: LoginResponseModel.self, httpMethod: .post, params: requestModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    debugPrint("error")
                    //self?.isPresentingError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] userModel in
                DispatchQueue.main.async {
                    debugPrint("login")
                    //self?.coordinator?.login()
                }
            }.store(in: &cancelables)
    }*/
}
