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
    func execute<T>(
        endpoint: Endpoint,
        decodingType: T.Type,
        httpMethod: HTTPMethod,
        params: Encodable) -> AnyPublisher<T, APIError> where T: Decodable
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
    public func execute<T>(
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
    }

    /*func loginV2(userName: String, password: String) -> AnyPublisher<UserModel, APIError> {
        /*guard let url = URL(string: "http://localhost:3001/login") else {
            return Fail(error: APIError.invalidRequestError("URL invalid"))
          .eraseToAnyPublisher()
        }*/
        
        guard let url = URL(string: "http://localhost:3001/login") else {
            return Fail(error: APIError.invalidRequestError("URL invalid"))
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = [
            "userName": userName,
            "password": password
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .withoutEscapingSlashes)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
            // handle URL errors (most likely not able to connect to the server)
            .mapError { error -> Error in
                return APIError.transportError(error)
            }
      
            // handle all other errors
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                print("Received response from server, now checking status code")
              
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                if (200..<300) ~= urlResponse.statusCode {
                    
                }
                else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIErrorMessage.self, from: data)

                    if urlResponse.statusCode == 400 {
                        throw APIError.validationError(apiError.errorDescription)
                    }

                    // uncomment this to auto retry
                    if (500..<600) ~= urlResponse.statusCode {
                        //let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                        throw APIError.serverError(
                            statusCode: urlResponse.statusCode,
                            reason: apiError.errorDescription/*,
                            retryAfter: retryAfter*/)
                    }
                }
                return (data, response)
            }

        return dataTaskPublisher
            /*.tryCatch { error -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                if case APIError.serverError = error {
                    return Just(Void())
                        .delay(for: 3, scheduler: DispatchQueue.global())
                        .flatMap { _ in
                            return dataTaskPublisher
                        }
                        .print("before retry")
                        .retry(10)
                        .eraseToAnyPublisher()
                }
                throw error
            }*/
            .map(\.data)
            //      .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder())
            .tryMap { data -> UserModel in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(UserModel.self, from: data)
                }
                catch {
                    throw APIError.decodingError(error)
                }
            }
            .mapError { error -> APIError in
                debugPrint("Este es el error que vamos a mapear: \(error)")
                return error as! APIError
                /*switch error {
                default:
                    return .transportError(error)
                }*/
            }
            //.map(\.isAvailable)
            //.replaceError(with: false)
            .eraseToAnyPublisher()
    }*/
}
