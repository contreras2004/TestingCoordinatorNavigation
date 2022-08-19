//
//  API.swift
//  Tolls
//
//  Created by m.contreras.selman on 15-07-22.
//

import Combine
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

public protocol ApiProtocol {
    /*func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable) -> AnyPublisher<T, APIError> where T: Decodable*/

    func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable?) async -> Result<T, APIError> where T: Decodable
}

public struct API: ApiProtocol {
    public init() { }

    public func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable? = nil) async -> Result<T, APIError> where T: Decodable {
        guard let url = URL(string: endpoint.fullUrl) else {
            return .failure(APIError.invalidRequestError("URL invalid"))
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        if let params = params {
            do {
                let jsonBody = try JSONEncoder().encode(params)
                request.httpBody = jsonBody
                debugPrint("Sending: \(params) to: \(request)")
            } catch {
                return .failure(APIError.encodingError(error))
            }
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            if (200..<300) ~= urlResponse.statusCode {
                do {
                    let decodedResponse = try JSONDecoder().decode(decodingType, from: data)
                    debugPrint("Response: \(decodedResponse)")
                    return .success(decodedResponse)
                } catch {
                    return .failure(.decodingError(error))
                }
            } else {
                let decoder = JSONDecoder()
                let apiError = try decoder.decode(APIErrorMessage.self, from: data)

                if urlResponse.statusCode == 400 {
                    return .failure(.invalidRequestError(apiError.errorDescription))
                }

                // uncomment this to auto retry
                if urlResponse.statusCode == 500 {
                    debugPrint(urlResponse)
                    debugPrint(apiError)
                    return .failure(.validationError(apiError))
                }
                // uncomment this to auto retry
                if (500..<600) ~= urlResponse.statusCode {
                    // let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                    return .failure(APIError.serverError(
                        statusCode: urlResponse.statusCode,
                        reason: apiError.errorDescription))
                }
            }
        } catch {
            return .failure(APIError.transportError(error))
        }
        return .failure(.invalidResponse)
    }
}
