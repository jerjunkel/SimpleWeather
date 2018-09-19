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
        setupForecastCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(dateAndTimeLabel)
        view.addSubview(locationLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(currentWeatherConditionImageView)
        view.addSubview(weatherStack)
        view.addSubview(forecastCollectionView)
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
            currentWeatherConditionImageView.heightAnchor.constraint(equalToConstant: 150),
            currentWeatherConditionImageView.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: currentWeatherConditionImageView.bottomAnchor, constant: 30)
            ])
        
        NSLayoutConstraint.activate([
            weatherStack.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            weatherStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            forecastCollectionView.heightAnchor.constraint(equalToConstant: 150),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func updateCurrentWeatherInterface() {
        guard let forecast = forecast else { return }
        guard let viewModel = forecast.currentWeather().weatherModels.first else { return }
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = viewModel.currentTempFahrenheitString
            self.dateAndTimeLabel.text = viewModel.dateFormatted
            self.locationLabel.text = forecast.city?.name
            self.currentWeatherConditionImageView.condition = viewModel.condition
            self.reloadCollectionView()
        }
    }
    
    private func updateFutureForecastStack() {
        DispatchQueue.main.async {
            guard let forecast = self.forecast else { return }
            let weatherModels = forecast.weatherModels
            let stackSubviews = self.weatherStack.arrangedSubviews.map { $0 as! LabeledWeatherView }
            
            for (index, view) in stackSubviews.enumerated() {
                view.title = weatherModels[index].time
                view.condition = weatherModels[index].condition
            }
        }
    }
    
    private func setupForecastCollectionView() {
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        forecastCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
    }
    
    private func reloadCollectionView() {
        forecastCollectionView.reloadData()
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
        label.font = UIFont.boldSystemFont(ofSize: 70)
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
    
    private var forecastCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.setAutoresizingMaskToFalse()
        collectionView.backgroundColor = .clear
        
        //        collectionView.collectionViewLayout = flowLayout
        return collectionView
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

extension CurrentWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecast = forecast else { return 0}
        return forecast.fiveDayForecast().weatherModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as!
        WeatherCollectionViewCell
        
        cell.weatherModel = forecast?.fiveDayForecast().weatherModels[indexPath.row]
        return cell
    }
}

