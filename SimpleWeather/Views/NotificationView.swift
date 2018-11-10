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
    private let padding: CGFloat = 5
    
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
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 70)
            ])
    }
    
    private func customizeView() {
        backgroundColor = App.Color.white.color
        layer.cornerRadius = 30
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.setAutoresizingMaskToFalse()
        label.textColor = App.Color.blue.color
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
}
