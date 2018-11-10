//
//  LabeledWeatherView.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/11/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class LabeledWeatherView: UIView {
    var condition: Weather.Condition = .clear {
        didSet{
            setImageFor(condition: condition)
        }
    }
    
    var title: String = "" {
        didSet {
            setLabel(text: title)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Utilities
    private func setupView() {
        addSubviews()
        setConstraints()
        setAutoresizingMaskToFalse()
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
            conditionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            conditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            conditionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
//            conditionImageView.heightAnchor.constraint(equalToConstant: 60),
//            conditionImageView.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    private func setImageFor(condition: Weather.Condition) {
        conditionImageView.condition = condition
    }
    
    private func setLabel(text: String) {
        titleLabel.text = text
    }
    
    func setLabelColor(color: UIColor) {
        titleLabel.textColor = color
    }
    //MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = App.Color.white.color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.setAutoresizingMaskToFalse()
        return label
    }()
    
    private var conditionImageView: WeatherImageView = {
        let imageView = WeatherImageView()
        return imageView
    }()
}
