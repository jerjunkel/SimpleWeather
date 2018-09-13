//
//  WeatherImageView.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 9/13/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class WeatherImageView: UIView {
    private let conditionImageNameDic: [Weather.Condition: String] = [
        .atmosphere: "mist_day.png",
        .clear: "clear_sky_day.png",
        .clouds: "broken_clouds_day.png",
        .drizzle: "rain_day.png",
        .rain: "shower_rain_day.png",
        .snow: "snow_day.png",
        .thunderStorm: "thunderstorm_day.png",
        .unknown: "mist_day.png"
    ]
    
    var condition: Weather.Condition = .unknown {
        didSet {
            setImageForWeatherCondition()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    private func setImageForWeatherCondition() {
        guard let imageStringName = conditionImageNameDic[condition],
            let image = UIImage(named: imageStringName) else { return }
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setAutoresizingMaskToFalse()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
