//
//  Extensions.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/11/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit

extension UIView {
    
    /// This sets `translatesAutoresizingMaskIntoContraints` to false
    func setAutoresizingMaskToFalse() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


extension UIColor {
    convenience init?(hexColor: String) {
        var hexString = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard hexString.count == 6 else { return nil }
        
        var rgb: UInt32 = 0
        
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                  blue: CGFloat((rgb & 0x0000FF)) / 255,
                  alpha: 1)
    }
}
