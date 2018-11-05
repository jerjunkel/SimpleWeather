//
//  SimpleWeatherTests.swift
//  SimpleWeatherTests
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import XCTest
@testable import SimpleWeather

class SimpleWeatherTests: XCTestCase {
    
    func testWeatherViewModelTempString() {
        let testWeatherModel = Weather(date: 112244436, mainDescription: "kind of sunny", temperature: Temperature(current: 300, min: 0, max: 0), condition: .clouds)
        
        let weatherViewModel = WeatherViewModel(weather: testWeatherModel)
        
        XCTAssertEqual(weatherViewModel.tempInFahrenheit, "80°F")
        XCTAssertEqual(weatherViewModel.tempInCelsius, "26°C")
    }
    
    func testWeatherViewModelDateConversion() {
        let testWeatherModel = Weather(date: 1541448123, mainDescription: "kind of sunny", temperature: Temperature(current: 300, min: 0, max: 0), condition: .clouds)
        
        let weatherViewModel = WeatherViewModel(weather: testWeatherModel)
        
        XCTAssertEqual(weatherViewModel.day, "Mon")
        XCTAssertEqual(weatherViewModel.dateFormatted, "Nov 5, 2018")
        XCTAssertEqual(weatherViewModel.time, "3:02 PM")
    }
    
}
