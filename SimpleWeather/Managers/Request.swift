//
//  RequestManager.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation
let apiKey = "4d8ddb62f90edd7eb29b003437141550"

enum HTTPMethod: String {
    case get = "GET"
}
///The properties needed to create a request type for network calls to an API
protocol RequestBuilder {
    var endPoint: String { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
}

extension RequestBuilder {
    var url: URL? {
        return URL(string: endPoint)
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url)
    }
}

struct Request: RequestBuilder {
    private(set) var endPoint: String
    private(set) var body: Data?
    private(set) var method: HTTPMethod = .get
}

///Results from a network call that has two possible results:-
///  -some
///  -error
enum ServerResponseError: Error {
    case badRequest
    case clientError
    case serverError
    case unknownError
}

enum Result<A, ErrorType: Error> {
    case success(A)
    case error(ErrorType)
}
