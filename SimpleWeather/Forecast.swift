//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

struct Forecast {
    var city: RawForecast.City?
    private var weatherArray: [Weather] = []
    //private var weatherViewModels: [WeatherViewModel] = []
    private var forecastJson: RawForecast?
    
    var weatherModels: [WeatherViewModel] {
        return weatherArray.map { WeatherViewModel(weather: $0) }
    }
    
    var weatherObjects: [Weather] {
       return weatherArray
    }
    
    init(weather: [Weather]) {
        self.weatherArray = weather
    }
    
    init(rawForecast: RawForecast) {
        forecastJson = rawForecast
        city = rawForecast.city
        makeWeatherObjects()
    }
    
    private mutating func makeWeatherObjects() {
        guard let json = forecastJson else { return }
        for weatherData in json.list {
            let weatherObject = Weather(weatherData: weatherData)
            weatherArray.append(weatherObject)
        }
    }
    
    func fiveHourForecast() -> Forecast {
        guard weatherArray.count > 5 else { return self }
        let fiveHourSlice = weatherArray[0..<5]
        var forecast = Forecast(weather: Array(fiveHourSlice))
        forecast.city = city
        return forecast
    }
    
    func fiveDayForecast() -> Forecast {
        var fiveDayweatherObjects: [Weather] = []
        
        for index in stride(from: 0, to: 40, by: 8) {
            fiveDayweatherObjects.append(weatherObjects[index])
        }
        return Forecast(weather: fiveDayweatherObjects)
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

extension Forecast: Sequence {
    typealias Element = Weather
    typealias Iterator = IndexingIterator<[Element]>
    typealias Subsquence = AnySequence
    
    func makeIterator() -> Iterator {
        return weatherArray.makeIterator()
    }
}
