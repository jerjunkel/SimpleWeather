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
    static func request(_ request: Request, onCompletion: @escaping (Result<Data, ServerResponse>) -> ()) {
        guard let urlRequest = request.urlRequest else {
            onCompletion(.error(.badRequest))
            return }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                if let serverResponse = response as? HTTPURLResponse {
                    var serverError = ServerResponse.unknownError
                    switch serverResponse.statusCode {
                    case 500...599:
                        serverError = .unknownError
                    case 400:
                        serverError = .badRequest
                    case 401...499:
                        serverError = .clientError
                    default:
                        serverError = .unknownError
                    }
                    onCompletion(.error(serverError))
                } else {
                    onCompletion(.error(.unknownError))
                }
                return
            }
            onCompletion(.some(data))
        }.resume()
    }
}
