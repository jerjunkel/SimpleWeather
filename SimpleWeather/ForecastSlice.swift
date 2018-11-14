//
//  ForecastSlice.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 11/14/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

///A slice of a Forecast instance.
struct ForecastSlice: Forecastable {
    var weatherArray: [Weather] = []
    var weatherModelsStore: [WeatherViewModel] = []
    var cityName: String?
    
    init(weather: [Weather]) {
        weatherArray = weather
        updateModelsStore()
    }
    
    init(weather: Weather...) {
        weatherArray = weatherArray + weather
        updateModelsStore()
    }
    
    mutating func add(weather: Weather) {
        weatherArray.append(weather)
        updateModelsStore()
    }
    
    mutating func add(forecast: ForecastSlice) {
        weatherArray = weatherArray + forecast.weatherArray
        updateModelsStore()
    }
    
    private mutating func updateModelsStore() {
        weatherModelsStore = weatherArray.map { WeatherViewModel(weather: $0) }
    }
}
