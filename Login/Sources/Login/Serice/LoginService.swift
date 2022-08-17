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

    func login(requestModel: LoginRequestModel) async -> Result<LoginResponseModel, LoginError>
}

public class LoginService: LoginServiceProtocol {
    var api: ApiProtocol = API()

    func login(requestModel: LoginRequestModel) async -> Result<LoginResponseModel, LoginError> {
        let response = await api.execute(
            endpoint: .login,
            decodingType: LoginResponseModel.self,
            httpMethod: .post,
            params: requestModel)
        switch response {
        case .success(let success):
            return .success(success)
        case .failure:
            return .failure(LoginError.unknown)
        }
    }
}
