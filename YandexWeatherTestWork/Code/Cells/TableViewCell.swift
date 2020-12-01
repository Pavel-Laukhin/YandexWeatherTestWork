//
//  TableViewCell.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    var city: City? {
        didSet {
            guard let city = city else { return }
            setupViews(for: city)
            setupLayout()
        }
    }
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var weatherConditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemTeal
        return imageView
    }()
    
    private func setupViews(for city: City) {
        cityNameLabel.text = city.cityName
        
        if city.degree > 0 {
            degreeLabel.text = "+\(city.degree)℃"
        } else if city.degree < 0 {
            degreeLabel.text = "-\(city.degree)℃"
        } else {
            degreeLabel.text = "0℃"
        }
    }
    
    private func setupLayout() {
        [cityNameLabel,
         degreeLabel,
         weatherConditionImage].forEach {
            contentView.addSubview($0)
            $0.toAutoLayout()
        }
        
        NSLayoutConstraint.activate([
            // add constrains
        ])
    }
    
}
