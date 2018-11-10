//
//  WeatherStack.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/12/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

class WeatherStack: UIView {
    private var views: [UIView] = []
    private let stackView: UIStackView = UIStackView ()
    private let padding: CGFloat  = 5
    private let itemHeight: CGFloat = 50
    
    convenience init(view: [UIView]) {
        self.init()
        self.views = view
        setFrameWidthAndHeight()
        setupStackView()
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        addViews()
        stackView.spacing = padding
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func addViews() {
        views.forEach { (view) in
            //view.layer.cornerRadius = itemHeight / 2
            self.stackView.addArrangedSubview(view)
        }
    }
    
    private func setFrameWidthAndHeight() {
        let numberOfItems = CGFloat(views.count)
        let width = numberOfItems * itemHeight + (numberOfItems + 1) * padding
        frame = CGRect(x: 0, y: 0, width: width, height: itemHeight + 2 * padding)
        stackView.frame = frame
    }
    
}
