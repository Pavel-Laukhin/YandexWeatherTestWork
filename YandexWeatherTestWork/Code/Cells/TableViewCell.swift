//
//  TableViewCell.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    var city: String? {
        didSet {
            guard let city = city else { return }
            setupViews(for: city)
            setupLayout()
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
    
    private lazy var weatherConditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemTeal
        return imageView
    }()
    
    private func setupViews(for city: String) {
        cityNameLabel.text = city
        
//        if city.degree > 0 {
//            degreeLabel.text = "+\(city.degree)℃"
//        } else {
//            degreeLabel.text = "\(city.degree)℃"
//        }
    }
    
    private func setupLayout() {
        [cityNameLabel,
         degreeLabel,
         weatherConditionImage].forEach {
            contentView.addSubview($0)
            $0.toAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.offset),
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            degreeLabel.trailingAnchor.constraint(equalTo: weatherConditionImage.leadingAnchor, constant: -Constants.offset),
            degreeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherConditionImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallOfset),
            weatherConditionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.offset),
            weatherConditionImage.widthAnchor.constraint(equalToConstant: Constants.size),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            weatherConditionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallOfset)
        ])
    }
    
}
