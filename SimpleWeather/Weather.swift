//
//  Weather.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

struct Temperature: Decodable {
    let current: Float
    let min: Float
    let max: Float
    
    var currentTempInCelsius: Float {
        return current - -273.15
    }
    
    var currentTempInFahrenheit: Float {
        return (current * 9/5) - 459.67
    }
}

struct Weather {
    var date: Double
    let mainDescription: String
    //let description: String
    let temperature: Temperature
    let condition: Condition
    
    enum Condition: String {
        case thunderStorm = "Thunderstorm"
        case drizzle = "Drizzle"
        case rain = "Rain"
        case snow = "Snow"
        case atmosphere = "Atmosphere"
        case clear = "Clear"
        case clouds = "Clouds"
        case unknown
    }
    
    init(weatherData: RawWeatherInfo) {
        date = weatherData.dt
        mainDescription = weatherData.weather.description
        
        let weatherMain = weatherData.main
        
        temperature = Temperature(current: weatherMain.temp, min: weatherMain.temp_min, max: weatherMain.temp_max)
        
        condition = Condition(rawValue: weatherData.weather[0].main) ?? .unknown
    }
}
