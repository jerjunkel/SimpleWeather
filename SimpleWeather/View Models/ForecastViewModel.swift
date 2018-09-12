//
//  ForecaseViewModel.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/7/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    private var forecastData: RawForecast {
        didSet {
            
        }
    }
    private(set) var weatherViewModels: [WeatherViewModel] = []
    
    init(rawForecast: RawForecast) {
        forecastData = rawForecast
        makeWeatherViewModels()
    }
    
    private mutating func makeWeatherViewModels() {
        for weatherData in forecastData.list {
            let weatherViewModel = WeatherViewModel(weatherData: weatherData)
            weatherViewModels.append(weatherViewModel)
        }
    }
}
