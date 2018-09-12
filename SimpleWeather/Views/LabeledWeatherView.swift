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
    private var condition: Weather.Condition = .clear
    
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
        setImageForWeatherCondition()
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
        imageView.backgroundColor = .green
        imageView.setAutoresizingMaskToFalse()
        return imageView
    }()
    
}
