//
//  CurrentWeatherViewController.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/11/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

protocol CurrentWeatherVCDelagate: class {
    func updateChild(forecast: Forecast)
}

class CurrentWeatherViewController: UIViewController {
    private var forecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK: - Utilities
    private func setupViewController() {
        view.backgroundColor = .clear
        addSubviews()
        setContraints()
    }
    
    private func addSubviews() {
        view.addSubview(dateAndTimeLabel)
        view.addSubview(locationLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(currentWeatherConditionImageView)
        view.addSubview(weatherStack)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            dateAndTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateAndTimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            ])
        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            currentWeatherConditionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherConditionImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            currentWeatherConditionImageView.heightAnchor.constraint(equalToConstant: 200),
            currentWeatherConditionImageView.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: currentWeatherConditionImageView.bottomAnchor, constant: 30)
            ])
        
        NSLayoutConstraint.activate([
            weatherStack.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            weatherStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    private func updateCurrentWeatherInterface() {
        guard let forecast = forecast else { return }
        guard let viewModel = forecast.weatherModels.first else { return }
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = viewModel.currentTempFahrenheitString
            self.dateAndTimeLabel.text = viewModel.dateFormatted
            self.locationLabel.text = forecast.city?.name
            self.currentWeatherConditionImageView.condition = viewModel.condition
        }
    }
    
    private func updateFutureForecastStack() {
        DispatchQueue.main.async {
            let weatherModels = self.forecast!.weatherModels
            let stackViews = self.weatherStack.arrangedSubviews.map { $0 as! LabeledWeatherView }
            
            for (index, view) in stackViews.enumerated() {
                view.title = weatherModels[index].time
                view.condition = weatherModels[index].condition
            }
        }
    }
    
    //MARK: - Properties
    private var dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.setAutoresizingMaskToFalse()
        label.text = "Dec 10th, 2017 -9:32 a.m"
        label.numberOfLines = 1
        label.textColor = App.Color.white.color
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.setAutoresizingMaskToFalse()
        label.text = "Location"
        label.numberOfLines = 2
        label.textColor = App.Color.white.color
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.setAutoresizingMaskToFalse()
        //label.text = "13°C"
        label.numberOfLines = 1
        label.textColor = App.Color.white.color
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    private var currentWeatherConditionImageView: WeatherImageView = {
        let imageView = WeatherImageView()
        imageView.setAutoresizingMaskToFalse()
        return imageView
    }()
    
    private var weatherStack: UIStackView = {
        
        let testViews = ["mon","tue","wed","thur","fri"].map({ (day) -> LabeledWeatherView in
            let weatherImage = LabeledWeatherView()
            return weatherImage
        })
        
        let stack = UIStackView(arrangedSubviews: testViews)
        stack.setAutoresizingMaskToFalse()
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        return stack
        
    }()
}

//MARK: - Parent Controller

extension CurrentWeatherViewController: CurrentWeatherVCDelagate {
    // func updateChild(with viewModel: WeatherViewModel, city: RawForecast.City) {
    //print(viewModel)
    //        DispatchQueue.main.async {
    //            self.temperatureLabel.text = viewModel.currentTempFahrenheitString
    //            self.dateAndTimeLabel.text = viewModel.dateFormatted
    //            self.locationLabel.text = city.name
    //        }
    //    }
    
    func updateChild(forecast: Forecast) {
        self.forecast = forecast
        updateCurrentWeatherInterface()
        updateFutureForecastStack()
    }
}
