//
//  LoginServiceMock.swift
//  
//
//  Created by m.contreras.selman on 05-08-22.
//

import Combine
import Foundation
import SwiftUI

@testable import Login

import Networking

class ForBundle {}

class LoginServiceMock: LoginServiceProtocol {
    enum ServiceState {
        case success, error, noReturn
    }

    var api: Networking.ApiProtocol = API()

    var cancelables = Set<AnyCancellable>()

    var serviceState: ServiceState = .success

    func login(requestModel: Login.LoginRequestModel, completion: @escaping (Result<Login.LoginResponseModel, Login.LoginError>) -> Void) {
        switch serviceState {
        case .success:
            let loginInfo = LoginResponseModel(name: "Matias Contreras")
            completion(.success(loginInfo))
        case .error:
            completion(.failure(Login.LoginError.unknown))
        case .noReturn:
            return
        }
    }
}
/*class MockAPI: ApiProtocol {
    
    func execute<T>(endpoint: Networking.Endpoint, decodingType: T.Type, httpMethod: Networking.HTTPMethod, params: Encodable) -> AnyPublisher<T, Networking.APIError> where T : Decodable {
        
        let json: Login.LoginResponseModel = JSONHelper.loadJSON(withFile: "loginError.json", inBundle: Bundle(for: LoginServiceMock.self))
        debugPrint(json)
        
        return publisher
    }
    
    
}*/

public enum JSONHelper {
    public static func loadJSON<Element: Decodable>(withFile fileName: String, inBundle bundle: Bundle) -> Element? {
        var jsonData: Element?

        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                jsonData = try decoder.decode(Element.self, from: data)
                return jsonData
            } catch {
                debugPrint(error)
            }
        } else {
            debugPrint("Could not find the json file: \(fileName) in bundle: \(bundle)")
        }
        return nil
    }
}

extension Foundation.Bundle {
    static var module: Bundle = {
        var thisModuleName = "Login_Login"
        var url = Bundle.main.bundleURL

        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            url = bundle.bundleURL.deletingLastPathComponent()
            thisModuleName = thisModuleName.appending("Tests")
        }

        url = url.appendingPathComponent("\(thisModuleName).bundle")

        guard let bundle = Bundle(url: url) else {
            fatalError("Foundation.Bundle.module could not load resource bundle: \(url.path)")
        }

        return bundle
    }()

    /// Directory containing resource bundle
    static var moduleDir: URL = {
        var url = Bundle.main.bundleURL
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            // remove 'ExecutableNameTests.xctest' path component
            url = bundle.bundleURL.deletingLastPathComponent()
        }
        return url
    }()
}
/*#if XCODE_BUILD
extension Foundation.Bundle {
    
    /// Returns resource bundle as a `Bundle`.
    /// Requires Xcode copy phase to locate files into `ExecutableName.bundle`;
    /// or `ExecutableNameTests.bundle` for test resources
    static var module: Bundle = {
        var thisModuleName = "Login"
        var url = Bundle.main.bundleURL
        
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            url = bundle.bundleURL.deletingLastPathComponent()
            thisModuleName = thisModuleName.appending("Tests")
        }
        
        url = url.appendingPathComponent("\(thisModuleName).bundle")
        
        guard let bundle = Bundle(url: url) else {
            fatalError("Foundation.Bundle.module could not load resource bundle: \(url.path)")
        }
        
        return bundle
    }()
    
    /// Directory containing resource bundle
    static var moduleDir: URL = {
        var url = Bundle.main.bundleURL
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            // remove 'ExecutableNameTests.xctest' path component
            url = bundle.bundleURL.deletingLastPathComponent()
        }
        return url
    }()
    
}
#endif
*/
