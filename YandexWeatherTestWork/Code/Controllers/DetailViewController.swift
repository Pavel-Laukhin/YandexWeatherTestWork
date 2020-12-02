//
//  DetailViewController.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "+25℃"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private lazy var weatherConditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemTeal
        return imageView
    }()
    
    private lazy var minDegreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Мин: -35℃"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var maxDegreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Макс: +35℃"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = "Ветер: С/З 5 м/с"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Влажность: 40%"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.text = "Атмосферное давление: 745 мм.рт.ст."
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    init(for city: City) {
        super.init(nibName: nil, bundle: nil)
        
        self.cityNameLabel.text = city.cityName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubviewsAndSetToAutoLayout()
        setupLayout()
    }
    
    private func addSubviewsAndSetToAutoLayout() {
        [cityNameLabel,
        degreeLabel,
        weatherConditionImage,
        minDegreeLabel,
        maxDegreeLabel,
        windLabel,
        humidityLabel,
        pressureLabel].forEach {
            view.addSubview($0)
            $0.toAutoLayout()
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.offset),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            degreeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: Constants.offset),
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minDegreeLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: Constants.smallOfset),
            minDegreeLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.offset),
            
            maxDegreeLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: Constants.smallOfset),
            maxDegreeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.offset),

            weatherConditionImage.topAnchor.constraint(equalTo: minDegreeLabel.bottomAnchor, constant: Constants.smallOfset),
            weatherConditionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherConditionImage.widthAnchor.constraint(equalToConstant: Constants.bigSize),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            
            windLabel.topAnchor.constraint(equalTo: weatherConditionImage.bottomAnchor, constant: Constants.offset),
            windLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: Constants.smallOfset),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Constants.smallOfset),
            pressureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}
