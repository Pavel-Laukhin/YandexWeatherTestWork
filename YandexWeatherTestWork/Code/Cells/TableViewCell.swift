//
//  TableViewCell.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit
import SwiftSVG

final class TableViewCell: UITableViewCell {
    
    var city: String? {
        didSet {
            guard let city = city else { return }
            setupViews(for: city)
            setupLayout()
        }
    }
    
    var weather: Weather? {
        didSet {
            guard let city = city else { return }
            setupViews(for: city)
        }
    }
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "+35℃"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var weatherCondition: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.turnOn()
        return indicator
    }()
    
    deinit {
        cityNameLabel.text = nil
        degreeLabel.text = nil
        if let subview = weatherCondition.subviews.first {
            subview.removeFromSuperview()
        }
    }
    
    private func setupViews(for city: String) {
        cityNameLabel.text = city
        
        // Настраиваем погоду:
        guard let weather = weather else { return }
        let temp = weather.fact.temp
        if temp > 0 {
            degreeLabel.text = "+\(temp)℃"
        } else {
            degreeLabel.text = "\(temp)℃"
        }
        
        fetchAndSetConditionImage(from: weather)
    }
    
    private func setupLayout() {
        [cityNameLabel,
         degreeLabel,
         weatherCondition,
         activityIndicator].forEach {
            contentView.addSubview($0)
            $0.toAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset),
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            degreeLabel.trailingAnchor.constraint(equalTo: weatherCondition.leadingAnchor, constant: -Constants.offset),
            degreeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherCondition.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallOffset),
            weatherCondition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset),
            weatherCondition.widthAnchor.constraint(equalToConstant: Constants.size),
            weatherCondition.heightAnchor.constraint(equalTo: weatherCondition.widthAnchor),
            weatherCondition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallOffset),
            
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset)
        ])
    }
    
    private func fetchAndSetConditionImage(from weather: Weather) {
        let conditionIconName = weather.fact.icon
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(conditionIconName).svg") {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let conditionImage = UIView(SVGURL: url) { image in
                    image.resizeToFit(self.weatherCondition.bounds)
                }
                self.weatherCondition.addSubview(conditionImage)
                self.activityIndicator.turnOff()
            }
        }
    }
    
}
