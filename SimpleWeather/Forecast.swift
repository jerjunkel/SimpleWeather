//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

///A collection of weather objects.
struct Forecast: Forecastable {
    var city: RawForecast.City?
    var weatherArray: [Weather] = []
    var weatherModelsStore: [WeatherViewModel] = []
    
    init(weather: [Weather]) {
        self.weatherArray = weather
    }
    
    init(forecastJson: RawForecast) {
        city = forecastJson.city
        makeWeatherObjects(from: forecastJson)
        makeWeatherViewModels()
    }
    
    private mutating func makeWeatherObjects(from json: RawForecast) {
        for weatherData in json.list {
            let weatherObject = Weather(weatherData: weatherData)
            weatherArray.append(weatherObject)
        }
    }
    
    private mutating func makeWeatherViewModels() {
        weatherModelsStore = weatherArray.map { WeatherViewModel(weather: $0) }
    }
    
    func currentWeather() -> ForecastSlice {
        guard let currentWeather = weatherArray.first else { return ForecastSlice()}
        return ForecastSlice(weather: currentWeather)
    }
    
    func fiveHourForecast() -> ForecastSlice {
        guard weatherArray.count > 5 else { return ForecastSlice(weather: self.weatherArray) }
        let fiveHourSlice = weatherArray[0..<5]
        let forecast = ForecastSlice(weather: Array(fiveHourSlice))
        return forecast
    }
    
    func fiveDayForecast() -> ForecastSlice {
        var fiveDayweatherObjects: [Weather] = []
        var weatherObjectCounter = 0
        
        for (index, weather) in weatherObjects.enumerated() where index % 8 == 0 {
            guard weatherObjectCounter <= 5 else { break }
            fiveDayweatherObjects.append(weather)
            weatherObjectCounter += 1
        }
        
        return ForecastSlice(weather: fiveDayweatherObjects)
    }
    
    mutating func add(_ weather: Weather) {
        weatherArray.append(weather)
    }
}
