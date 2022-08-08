//
//  APIError.swift
//  Tolls
//
//  Created by m.contreras.selman on 20-07-22.
//

import Foundation

public struct APIErrorMessage: Decodable {
    public var errorDescription: String
    public var errorCode: Int64
}

public enum APIError: Error {
    /// Invalid request, e.g. invalid URL
    case invalidRequestError(String)

    /// Indicates an error on the transport layer, e.g. not being able to connect to the server
    case transportError(Error)

    /// Received an invalid response, e.g. non-HTTP result
    case invalidResponse

    /// Server-side validation error
    case validationError(APIErrorMessage)

    /// The server sent data in an unexpected format
    case decodingError(Error)

    /// Could not encode the data to send to the server
    case encodingError(Error)

    /// General server-side error. If `retryAfter` is set, the client can send the same request after the given time.
    case serverError(statusCode: Int, reason: String? = nil/*, retryAfter: String? = nil*/)

    var errorDescription: String? {
        switch self {
        case .invalidRequestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let error):
            return "Transport error: \(error)"
        case .invalidResponse:
            return "Invalid response"
        case .validationError(let reason):
            return "Validation Error: \(reason)"
        case .decodingError:
            return "The server returned data in an unexpected format. Try updating the app."
        case .encodingError(let reason):
            return "Could not encode the data: \(reason)"
        case let .serverError(statusCode, reason/*, retryAfter*/):
            return "Server error with code \(statusCode), reason: \(reason ?? "no reason given")"
        }
    }
}
