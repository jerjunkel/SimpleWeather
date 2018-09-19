//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    private var forecast: Forecast? {
        didSet{
            updateCurrentWeatherVC()            
        }
    }
    private var currentWeatherVC: CurrentWeatherViewController = CurrentWeatherViewController()
    private weak var currentWeatherVCDelegate: CurrentWeatherVCDelagate?
    private var currentLocation: Coordinates? {
        didSet {
            fetchWeatherJson()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    //MARK: - Utilites
    private func setupViewController() {
        view.backgroundColor = App.Color.blue.color
        LocationManager.shared.delegate = self
        addCurrentWeatherViewController()
    }
    
    private func addCurrentWeatherViewController() {
        addViewControllerToParent(currentWeatherVC)
        currentWeatherVCDelegate = currentWeatherVC
    }
    
    private func addViewControllerToParent(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    private func updateCurrentWeatherVC() {
        guard let forecast = forecast else { return }
        //guard let currentWeatherViewModel = forecast.weatherModels.first else { return }
        //currentWeatherVCDelegate?.updateChild(with: currentWeatherViewModel, city: forecast.city!)
        currentWeatherVCDelegate?.updateChild(forecast: forecast)
    }
}

//MARK: - Forecast Info
extension WeatherViewController {
    private func fetchWeatherJson() {
        guard let request = makeRequest() else { return }
        getForecastData(from: request)
    }
    
    private func makeRequest() -> Request? { // Throw error
        guard let location = currentLocation else { return nil }
        
        var testEndpointString = "https://samples.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.long)"
        testEndpointString += "&appid=ff132cc17572caedfaed5e2a6d9ec19b"
        
        var endpointString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.long)"
        endpointString += "&appid=\(apiKey)"
        
        return Request(endPoint: testEndpointString, body: nil, method: .get)
    }
    
    private func getForecastData(from request: Request) {
        Task.request(request) { (response) in
            self.handleResponse(response)
        }
    }
    
    private func handleResponse(_ response: Result<Data, ServerResponse>) {
        switch response {
        case .some(let data):
            let decoder = JSONDecoder()
            
            do {
                let jsonData = try decoder.decode(RawForecast.self, from: data)
                self.forecast = Forecast(forecastJson: jsonData)
                
            } catch {
                print(error.localizedDescription)
            }
            
        case .error:
            break
        }
    }
}

//MARK: - Location Consuming Delegate Methods
extension WeatherViewController: LocationConsuming {
    func locationStatusDidChange(to status: LocationStatus) {
        switch status {
        case .newLocation(let location):
            //print(location)
            let locationCoordinates = location.coordinate
            currentLocation = Coordinates(lat: locationCoordinates.latitude, long: locationCoordinates.longitude)
            //currentLocation = LocationManager.shared.currentLocationCoordinates
        case .locationUnreachable:
            break
        }
    }
}
