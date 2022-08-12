//
//  File.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import Foundation
import Networking

protocol RegisterServiceProtocol {
    var api: ApiProtocol { get }
    var cancelables: Set<AnyCancellable> { get }

    func register(requestModel: LoginRequestModel, completion: @escaping (Result<LoginResponseModel, LoginError>) -> Void)
}

class RegisterService {
    
}

   
