//
//  NotificationView.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 9/26/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import UIKit
/// A view used to notify users of errors and application status changes.
class NotificationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Utilities
    func setNotification(message: String) {
        label.text = message.capitalized
    }
    
    //MARK:- Setup Utilities
    private func setupView() {
        setAutoresizingMaskToFalse()
        addSubview(label)
        setConstraints()
        customizeView()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150)
            ])
    }
    
    private func customizeView() {
        backgroundColor = App.Color.white.color
        layer.cornerRadius = 40
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.setAutoresizingMaskToFalse()
        label.textColor = App.Color.blue.color
        label.numberOfLines = 1
        return label
    }()
}
