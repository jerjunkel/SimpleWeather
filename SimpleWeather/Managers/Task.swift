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
    static func request(_ request: Request, closure: @escaping (Response) -> ()) {
        guard let urlRequest = request.urlRequest else {
            closure(.error)
            return }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                closure(.some(data))
            } else {
                closure(.error)
            }
        }.resume()
    }
}
