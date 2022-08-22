//
//  LoginService.swift
//  Tolls
//
//  Created by m.contreras.selman on 21-07-22.
//

import Combine
import Foundation
import Networking
import SwiftUI

enum LoginError: Int64, Error {
    case nonExistingUser = 1
    case invalidPassword = 2
    case unknown

    var title: String {
        L10n.errorTitle
    }

    var message: String {
        switch self {
        case .nonExistingUser:
            return L10n.loginErrorCode1
        case .invalidPassword:
            return L10n.loginErrorCode2
        case .unknown:
            return L10n.errorMessage
        }
    }
}

protocol LoginServiceProtocol {
    var api: ApiProtocol { get }

    func login(requestModel: LoginRequestModel, completion: @escaping (Result<LoginResponseModel, LoginError>) -> Void )
}

public class LoginService: LoginServiceProtocol {
    var api: ApiProtocol = API()

    func login(requestModel: LoginRequestModel, completion: @escaping (Result<LoginResponseModel, LoginError>) -> Void) {
        Task {
            let response = await self.api.execute(
                endpoint: .login,
                decodingType: LoginResponseModel.self,
                httpMethod: .post,
                params: requestModel)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    return completion(.success(success))
                case .failure(let error):
                    switch error {
                    case .validationError(let error):
                        return completion(.failure(LoginError(rawValue: error.errorCode) ?? .unknown))
                    default:
                        return completion(.failure(LoginError.unknown))
                    }
                }
            }
        }
    }
}
