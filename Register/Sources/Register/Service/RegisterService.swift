//
//  File.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import Combine
import Foundation
import Networking
import SwiftUI

enum RegisterError: Int64, Error {
    case userAlreadyExists = 1
    case unknown

    var title: String {
        L10n.errorTitle
    }

    var message: String {
        switch self {
        case .userAlreadyExists:
            return L10n.registerErrorCode1
        case .unknown:
            return L10n.errorMessage
        }
    }
}

protocol RegisterServiceProtocol {
    var api: ApiProtocol { get }
    var cancelables: Set<AnyCancellable> { get }

    func register(requestModel: RegisterRequestModel, completion: @escaping (Result<Void, RegisterError>) -> Void)
}

class RegisterService: RegisterServiceProtocol {
    var cancelables = Set<AnyCancellable>()

    var api: Networking.ApiProtocol = API()

    func register(requestModel: RegisterRequestModel, completion: @escaping (Result<Void, RegisterError>) -> Void) {
        api.execute(endpoint: .register, decodingType: RegisterResponseModel.self, httpMethod: .post, params: requestModel)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    switch error {
                    case .validationError(let error):
                        completion(.failure(RegisterError(rawValue: error.errorCode) ?? .unknown))
                    default:
                        completion(.failure(RegisterError.unknown))
                    }
                case .finished:
                    break
                }
            } receiveValue: { _ in
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            }.store(in: &cancelables)
    }
}
