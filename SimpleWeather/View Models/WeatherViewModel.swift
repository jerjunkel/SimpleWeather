//
//  WeatherViewModel.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/7/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    let date: Double
    let currentTemp: Float
//    let minTemp: Float
//    let maxTemp: Float
    let currentDiscription: String
    let condition: Weather.Condition
    
    private var dateObject: Date {
        return Date(timeIntervalSince1970: date)
    }
    
    var currentTempCelsiusString: String {
        let temp = currentTemp + -273.15
        return "\(String(format: "%.2d", temp))°C"
    }
    
    var currentTempFahrenheitString: String {
        let temp = (currentTemp * 9/5) - 459.67
        return "\(Int(temp))°F"
    }
    
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: dateObject)
        return localDate
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        let localDate = dateFormatter.string(from: dateObject)
        return localDate
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let day = dateFormatter.string(from: dateObject)
        return day
    }
    
    init(weather: Weather) {
        date = weather.date
        currentTemp = weather.temperature.current
        currentDiscription = weather.mainDescription
        condition = weather.condition
    }
}
