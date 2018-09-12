//
//  RawJson.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/7/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

//struct RawWeather: Decodable {
//    let coord: Coordinates
//    let weather: [WeatherRaw]
//    let base: String
//    //    let main: MainRaw
//    //    let wind: Wind
//    //    let clouds: Clouds
//    //    let dt: Int
//    //    let sys: SystemInfo
//    //    let id: Int
//    //  //  let name: String
//    //    let cod: Int
//
//    struct Coordinates: Decodable {
//        let lon: Float
//        let lat: Float
//    }
//
//    struct WeatherRaw: Decodable {
//        let id: Int
//        let main: String
//        let description: String
//        let icon: String
//    }
//
//    struct MainRaw: Decodable {
//        let temp: Float
//        let pressure: Float
//        let humidity: Float
//        let temp_max: Float
//        let temp_min: Float
//        let sea_level: Float
//        let grnd_level: Float
//
//        var currentTempInCelsius: Float {
//            return temp - -273.15
//        }
//
//        var currentTempInFahrenheit: Float {
//            return (temp * 9/5) - 459.67
//        }
//    }
//
//    struct Wind: Decodable {
//        let speed: Float
//        let deg: Int
//    }
//
//    struct Clouds: Decodable {
//        let all: Int
//    }
//
//    struct SystemInfo: Decodable {
//        let message: Float
//        let country: String
//        let sunrise: Int
//        let sunset: Int
//    }

//    enum CodingKeys: CodingKey {
//        case coord, weather, base, main, wind, clouds, dt, sys, id, name, cod
//    }
//
//    init(from decoder: Decoder) throws {
//        let containter = try decoder.container(keyedBy: CodingKeys.self)
//
//        coord = try? containter.decode(Coordinates.self, forKey: .coord)
//        weather = try? containter.decode([WeatherRaw].self, forKey: .weather)
//        base = try? containter.decode(String.self, forKey: .base)
//        main = try? containter.decode(MainRaw.self, forKey: .main)
//        wind = try? containter.decode(Wind.self, forKey: .wind)
//        clouds = try? containter.decode(Clouds.self, forKey: .clouds)
//        dt = try? containter.decode(Int.self, forKey: .dt)
//        sys = try? containter.decode(SystemInfo.self, forKey: .sys)
//        id = try? containter.decode(Int.self, forKey: .id)
//        name = try? containter.decode(String.self, forKey: .name)
//        cod = try? containter.decode(Int.self, forKey: .cod)
//    }
//}

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
