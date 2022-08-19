//
//  LoginServiceMock.swift
//  
//
//  Created by m.contreras.selman on 05-08-22.
//

import Combine
import Foundation
import SwiftUI
import TestUtils

@testable import Login

import Networking

class ForBundle {}

class LoginServiceMock: LoginServiceProtocol {
    func login(requestModel: Login.LoginRequestModel, completion: @escaping (Result<Login.LoginResponseModel, Login.LoginError>) -> Void) {
        switch serviceState {
        case .success:
            let response: LoginResponseModel = JSONHelper.loadJSON(withFile: "loginSuccess", inBundleWithName: "Login", subdirectory: "JSON")!
            completion(.success(response))
        case .error:
            let error: APIErrorMessage = JSONHelper.loadJSON(withFile: "loginError", inBundleWithName: "Login", subdirectory: "JSON")!
            completion(.failure(Login.LoginError(rawValue: error.errorCode) ?? .unknown))
        case .noReturn:
            sleep(10)
            completion(.failure(Login.LoginError.unknown))
        }
    }
    
    enum ServiceState {
        case success, error, noReturn
    }

    var api: Networking.ApiProtocol = API()

    var serviceState: ServiceState = .success

    func login(requestModel: Login.LoginRequestModel) async -> Result<Login.LoginResponseModel, Login.LoginError> {
        switch serviceState {
        case .success:
            let response: LoginResponseModel = JSONHelper.loadJSON(withFile: "loginSuccess", inBundleWithName: "Login", subdirectory: "JSON")!
            return .success(response)
        case .error:
            let error: APIErrorMessage = JSONHelper.loadJSON(withFile: "loginError", inBundleWithName: "Login", subdirectory: "JSON")!
            return .failure(Login.LoginError(rawValue: error.errorCode) ?? .unknown)
        case .noReturn:
            sleep(10)
            return .failure(Login.LoginError.unknown)
        }
    }
}
