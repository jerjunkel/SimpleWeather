//
//  RawJson.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/7/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

///A codable structure that represent the top level json that is returned from the weather api endpoint.
struct RawForecast: Decodable {
    let city: City
    let list: [RawWeatherInfo]
    
    struct City: Decodable {
        let id: Double
        let name: String
        let country: String
        let coord: Coordinates
        
        struct Coordinates: Decodable {
            let lat: Double
            let lon: Double
        }
    }
}
///A codable structure that represents weather values returned from the weather api endpoint.
struct RawWeatherInfo: Decodable {
    let dt: Double
    let main: MainRaw
    let weather: [WeatherRaw]
    
    struct MainRaw: Decodable {
        let temp: Float
        let pressure: Float
        let humidity: Float
        let temp_max: Float
        let temp_min: Float
        let sea_level: Float
        let grnd_level: Float
    }
    
    struct WeatherRaw: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Wind: Decodable {
        let speed: Float
        let deg: Int
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
}
