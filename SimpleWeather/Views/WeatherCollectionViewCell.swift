//
//  WeatherCollectionViewCell.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 9/18/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let identifier = "forecastCellID"
    var weatherModel: WeatherViewModel? {
        didSet {
            updateCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCell() {
        guard let viewModel = weatherModel else { return }
        DispatchQueue.main.async {
            self.labeledWeatherView.title = viewModel.dateFormatted
            self.labeledWeatherView.condition = viewModel.condition
        }
    }
    
    private func customizeContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    private func setupCell() {
        setAutoresizingMaskToFalse()
        customizeCell()
        addLabeledView()
    }
    
    private func addLabeledView() {
        addSubview(labeledWeatherView)
        NSLayoutConstraint.activate([
            labeledWeatherView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            labeledWeatherView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labeledWeatherView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labeledWeatherView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    private func customizeCell() {
        customizeContentView()
    }
    
    private var labeledWeatherView: LabeledWeatherView = {
        let label = LabeledWeatherView()
        label.setLabelColor(color: .black)
        return label
    }()
}
