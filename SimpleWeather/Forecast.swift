//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

protocol Forecastable: Sequence where
    Iterator == IndexingIterator<[Element]>,
    Element == Weather {
    
    var weatherArray: [Weather] { get set }
    init (weather: [Weather])
}

extension Forecastable {
    typealias Subsquence = AnySequence
    
    func makeIterator() -> Iterator {
        return weatherArray.makeIterator()
    }
    
    var weatherModels: [WeatherViewModel] {
        return weatherArray.map { WeatherViewModel(weather: $0) }
    }
    
    var weatherObjects: [Weather] {
        return weatherArray
    }
}

///A collection of weather objects.
struct Forecast: Forecastable {
    var city: RawForecast.City?
    var weatherArray: [Weather] = []
    
    init(weather: [Weather]) {
        self.weatherArray = weather
    }
    
    init(forecastJson: RawForecast) {
        city = forecastJson.city
        makeWeatherObjects(from: forecastJson)
    }
    
    private mutating func makeWeatherObjects(from json: RawForecast) {
        for weatherData in json.list {
            let weatherObject = Weather(weatherData: weatherData)
            weatherArray.append(weatherObject)
        }
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
        
        for index in stride(from: 0, to: 40, by: 8) {
            fiveDayweatherObjects.append(weatherObjects[index])
        }
        return ForecastSlice(weather: fiveDayweatherObjects)
    }
    
    mutating func add(_ weather: Weather) {
        weatherArray.append(weather)
    }
}

//extension Forecast: ExpressibleByArrayLiteral {
//    typealias ArrayLiteralElement = Element
//
//    init(arrayLiteral elements: Element...) {
//        weatherArray += elements
//    }
//}

///A slice of a Forecast instance.
struct ForecastSlice: Forecastable {
    var weatherArray: [Weather] = []
    var cityName: String?
    
    init(weather: [Weather]) {
        weatherArray = weather
    }
    
    init(weather: Weather...) {
        weatherArray = weatherArray + weather
    }
    
    mutating func add(weather: Weather) {
        weatherArray.append(weather)
    }
    
    mutating func add(forecast: ForecastSlice) {
        weatherArray = weatherArray + forecast.weatherArray
    }
}
