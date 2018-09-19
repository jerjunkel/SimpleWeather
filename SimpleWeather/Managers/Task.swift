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
    static func request(_ request: Request, onComplete: @escaping (Response) -> ()) {
        guard let urlRequest = request.urlRequest else {
            onComplete(.error)
            return }
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                onComplete(.some(data))
            } else {
                onComplete(.error)
            }
        }.resume()
    }
}
