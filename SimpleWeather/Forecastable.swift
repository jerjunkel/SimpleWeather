//
//  Forecastable.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 10/18/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import Foundation

protocol Forecastable: Sequence where
    Iterator == IndexingIterator<[Element]>,
    Element == Weather {
    
    var weatherArray: [Weather] { get set }
    var weatherModelsStore: [WeatherViewModel] { get set }
    init (weather: [Weather])
}

extension Forecastable {
    typealias Subsquence = AnySequence
    
    func makeIterator() -> Iterator {
        return weatherArray.makeIterator()
    }
    
    func getWeatherAllViewModels() -> [WeatherViewModel] {
        return weatherModelsStore
    }
    
    func getWeatherModel(at index: Int) -> WeatherViewModel? {
        guard index < weatherModelsStore.count else {
            return nil
        }
        
        return weatherModelsStore[index]
    }
    
    var weatherObjects: [Weather] {
        return weatherArray
    }
}
