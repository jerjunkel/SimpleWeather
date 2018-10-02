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
    private let notificationView = NotificationView()
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
    
    //MARK: - Setup Utilites
    private func setupViewController() {
        view.backgroundColor = App.Color.blue.color
        LocationManager.shared.delegate = self
        addCurrentWeatherViewController()
        addNotificationViewAndSetConstraints()
    }
    
    private func addCurrentWeatherViewController() {
        addViewControllerToParent(currentWeatherVC)
        currentWeatherVCDelegate = currentWeatherVC
    }
    
    private func addViewControllerToParent(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    private func updateCurrentWeatherVC() {
        guard let forecast = forecast else { return }
        //guard let currentWeatherViewModel = forecast.weatherModels.first else { return }
        //currentWeatherVCDelegate?.updateChild(with: currentWeatherViewModel, city: forecast.city!)
        currentWeatherVCDelegate?.updateChild(forecast: forecast)
    }
    
    //MARK:- Notification View Utilities
    private func addNotificationViewAndSetConstraints() {
        view.addSubview(notificationView)
        
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: view.bottomAnchor),
            notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
            ])
    }
    
    private func showNotificationView() {
        UIView.animate(withDuration: 0.5) {
            self.notificationView.transform = CGAffineTransform(translationX: 0, y: -100)
        }
    }
    
    private func hideNotificationView() {
        UIView.animate(withDuration: 0.5) {
            self.notificationView.transform = CGAffineTransform.identity
        }
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
            
        case let .error(serverError):
            handleServerError(error: serverError)
        }
    }
    
    private func handleServerError(error: ServerResponse) {
        switch error {
        case .badRequest:
            print("Bad Request")
        case .clientError:
            print("clientError")
        case .serverError:
            print("serverError")
        case .unknownError:
            print("unknownError")
        default:
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
            hideNotificationView()
        case .locationUnreachable:
            showErrorPopUp(message: "Location unreachable")
        case .authorizationNeeded:
            showErrorPopUp(message: "User needs to authorize application")
        }
    }
    
    private func showErrorPopUp(message: String) {
        notificationView.setNotification(message: message)
        showNotificationView()
    }
}
