//
//  Task.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

class Task {
    static let session = URLSession(configuration: .default)
    static func request(_ request: Request, onCompletion: @escaping (Result<Data, ServerResponseError>) -> ()) {
        guard let urlRequest = request.urlRequest else {
            onCompletion(.error(.badRequest))
            return }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                if let serverResponse = response as? HTTPURLResponse {
                    var serverResponseError = ServerResponseError.unknownError
                    switch serverResponse.statusCode {
                    case 500...599:
                        serverResponseError = .serverError
                    case 400:
                        serverResponseError = .badRequest
                    case 401...499:
                        serverResponseError = .clientError
                    default:
                        serverResponseError = .unknownError
                    }
                    onCompletion(.error(serverResponseError))
                }
                return
            }
            onCompletion(.success(data))
            }.resume()
    }
}
