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

    func register(requestModel: RegisterRequestModel) async -> Result<Void, RegisterError>
}

class RegisterService: RegisterServiceProtocol {
    var api: Networking.ApiProtocol = API()

    func register(requestModel: RegisterRequestModel) async -> Result<Void, RegisterError> {
        let response = await api.execute(
            endpoint: .register,
            decodingType: RegisterResponseModel.self,
            httpMethod: .post,
            params: requestModel)
        switch response {
        case .success:
            return .success(())
        case .failure(let error):
            switch error {
            case .validationError(let error):
                return .failure(RegisterError(rawValue: error.errorCode) ?? .unknown)
            default:
                return .failure(RegisterError.unknown)
            }
        }
    }
}
