//
//  UIActivityIndicatiorView Extension.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 04.12.2020.
//

import UIKit

extension UIActivityIndicatorView {
    
    public func turnOn() {
        isHidden = false
        startAnimating()
    }
    
    public func turnOff() {
        isHidden = true
        stopAnimating()
    }
    
}
