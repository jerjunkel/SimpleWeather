//
//  AppColors.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/11/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

struct App {
    enum Color: String {
        case lightBLue = "#ADC2C8"
        case blue = "#326875"
        case white = "#FCFCFC"
        case yellow = "#F9D17C"

        var color: UIColor {
            guard let color = UIColor(hexColor: rawValue) else {
                return UIColor.black }
            return color
        }
    }
}
