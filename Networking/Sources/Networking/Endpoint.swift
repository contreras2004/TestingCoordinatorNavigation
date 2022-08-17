//
//  Endpoint.swift
//  Tolls
//
//  Created by m.contreras.selman on 21-07-22.
//

import Foundation

public enum Endpoint: String {
    case login
    case register
    case notifications

    private var baseUrl: String { "http://localhost:3001/" }

    public var fullUrl: String {
        switch self {
        case .login:
            return baseUrl + self.rawValue
        case .register:
            return baseUrl + self.rawValue
        case .notifications:
            return baseUrl + self.rawValue
        }
    }
}
