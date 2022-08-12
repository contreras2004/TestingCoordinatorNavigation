//
//  File.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import Foundation

struct RegisterRequestModel: Codable {
    let userName: String
    let email: String
    let pass: String
}

struct RegisterResponseModel: Codable {
}
