//
//  LabeledWeatherView.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/11/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class LabeledWeatherView: UIView {
    private var label: String = ""
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
    var condition: Weather.Condition = .clear {
        didSet{
            setImageForWeatherCondition()
        }
    }
    
     convenience init(_ label: String, condition:  Weather.Condition) {
        self.init()
        self.label = label
        self.condition = condition
        setupView()
    }
    
    //MARK: - Utilities
    private func setupView() {
        addSubviews()
        setConstraints()
        setLabelText()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(conditionImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            conditionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            conditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            conditionImageView.heightAnchor.constraint(equalToConstant: 60),
            conditionImageView.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    private func setImageForWeatherCondition() {
        guard let imageString = conditionImageNameDic[condition],
            let image = UIImage(named: imageString) else { return }
        
        DispatchQueue.main.async {
            self.conditionImageView.image = image
        }
    }
    
    private func setLabelText() {
        titleLabel.text = label
    }
    
    //MARK: - Properties
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = App.Color.white.color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.setAutoresizingMaskToFalse()
        return label
    }()
    
    private var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setAutoresizingMaskToFalse()
        return imageView
    }()
    
}
