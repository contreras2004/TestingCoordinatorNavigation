//
//  LoginModels.swift
//  Tolls
//
//  Created by m.contreras.selman on 21-07-22.
//

import Foundation

struct LoginResponseModel: Codable {
    let name: String
}

struct LoginRequestModel: Codable {
    let userName: String
    let password: String
}
