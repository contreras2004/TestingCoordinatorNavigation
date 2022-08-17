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
        params: Encodable) async -> Result<T, APIError> where T: Decodable
}

public struct API: ApiProtocol {
    public init() { }
    /*func login(userName: String, password: String) -> AnyPublisher<UserModel?, Never> {
        
        guard let url = URL(string: "http://localhost:3001/login") else {
            return Just(nil).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = [
            "userName": userName,
            "password": password
        ]
        //request.httpBody = params.description.data(using: .utf8)
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .withoutEscapingSlashes)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: UserModel?.self, decoder: JSONDecoder())
            .catch({ _ in
                Just(nil)
            })
            .replaceError(with: nil)
            .eraseToAnyPublisher()
                    
        return publisher
    }*/

    // swiftlint:disable function_body_length
    /*public func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable) -> AnyPublisher<T, APIError> where T: Decodable {
        guard let url = URL(string: endpoint.fullUrl) else {
            return Fail(error: APIError.invalidRequestError("URL invalid"))
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        do {
            let jsonBody = try JSONEncoder().encode(params)
            request.httpBody = jsonBody
        } catch {
            return Fail(error: APIError.encodingError(error))
                .eraseToAnyPublisher()
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
            // handle URL errors (most likely not able to connect to the server)
            .mapError { error -> Error in
                APIError.transportError(error)
            }

            // handle all other errors
            .tryMap { data, response -> (data: Data, response: URLResponse) in
                print("Received response from server, now checking status code")

                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                if (200..<300) ~= urlResponse.statusCode {
                } else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIErrorMessage.self, from: data)

                    if urlResponse.statusCode == 400 {
                        throw APIError.invalidRequestError(apiError.errorDescription)
                    }

                    // uncomment this to auto retry
                    if urlResponse.statusCode == 500 {
                        throw APIError.validationError(apiError)
                    }
                    // uncomment this to auto retry
                    if (500..<600) ~= urlResponse.statusCode {
                        // let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                        throw APIError.serverError(
                            statusCode: urlResponse.statusCode,
                            reason: apiError.errorDescription
                            /*, retryAfter: retryAfter*/)
                    }
                }
                return (data, response)
            }

        return dataTaskPublisher
            .map(\.data)
            .tryMap { data -> T in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError(error)
                }
            }
            .mapError { error -> APIError in
                guard let error = error as? APIError else { return APIError.invalidResponse }
                return error
            }
            .eraseToAnyPublisher()
    }*/

    public func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable) async -> Result<T, APIError> where T: Decodable {
        guard let url = URL(string: endpoint.fullUrl) else {
            return .failure(APIError.invalidRequestError("URL invalid"))
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        do {
            let jsonBody = try JSONEncoder().encode(params)
            request.httpBody = jsonBody
        } catch {
            return .failure(APIError.encodingError(error))
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
