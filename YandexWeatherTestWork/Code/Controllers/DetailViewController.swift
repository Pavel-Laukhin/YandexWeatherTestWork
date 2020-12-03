//
//  DetailViewController.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var callback: (() -> Void)?
    
    private var cities = CitiesImpl.shared
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "малооблачно"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "+25°"
        label.font = UIFont.systemFont(ofSize: 100)
        return label
    }()
    
    private lazy var degreeFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ощущается как +20℃"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        label.text = "Атм. давление: 745 мм.рт.ст."
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    init(forCity: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.cityNameLabel.text = forCity.capitalized
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.setupUI(city: forCity)
        }
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
         conditionLabel,
         degreeLabel,
         degreeFeelsLikeLabel,
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
            cityNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.offset),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.offset),
            
            conditionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.offset),
            conditionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.offset),
                        
            degreeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: Constants.offset),
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            degreeFeelsLikeLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor),
            degreeFeelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minDegreeLabel.topAnchor.constraint(equalTo: degreeFeelsLikeLabel.bottomAnchor, constant: Constants.offset),
            minDegreeLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.offset),
            
            maxDegreeLabel.topAnchor.constraint(equalTo: minDegreeLabel.topAnchor),
            maxDegreeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.offset),

            weatherConditionImage.topAnchor.constraint(equalTo: minDegreeLabel.bottomAnchor, constant: Constants.smallOffset),
            weatherConditionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherConditionImage.widthAnchor.constraint(equalToConstant: Constants.bigSize),
            weatherConditionImage.heightAnchor.constraint(equalTo: weatherConditionImage.widthAnchor),
            
            windLabel.topAnchor.constraint(equalTo: weatherConditionImage.bottomAnchor, constant: Constants.offset),
            windLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: Constants.smallOffset),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Constants.smallOffset),
            pressureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupUI(city: String) {
        guard let weather = fetchWeather(city: city) else { return }
        let condition = setConditionDescription(condition: weather.fact.condition).firstCapitalized
        let temp = weather.fact.temp
        let tempIsFelt = weather.fact.feelsLike
        let tempMin = weather.forecasts.first?.parts.evening.tempMin
        let tempMax = weather.forecasts.first?.parts.day.tempMax
        let windValue = weather.fact.windSpeed
        let windDirection = setWindDescription(wind: weather.fact.windDirection)
        let humidity = weather.fact.humidity
        let pressure = weather.fact.pressure
        
        // MARK: Setting up labels
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.conditionLabel.text = condition
            self.degreeLabel.text = temp > 0 ? "+\(temp)°" : "\(temp)°"
            self.degreeFeelsLikeLabel.text = tempIsFelt > 0 ? "+\(tempIsFelt)℃" : "По ощущениям \(tempIsFelt)℃"
            self.windLabel.text = "Ветер: \(windDirection) \(windValue) м/с"
            self.humidityLabel.text = "Влажность: \(humidity)%"
            self.pressureLabel.text = "Атм. давление: \(pressure) мм.рт.ст."
            
            if tempMin != nil {
                self.minDegreeLabel.text =  tempMin! > 0 ? "Мин: +\(tempMin!)℃" : "Мин: \(tempMin!)℃"
            } else {
                self.minDegreeLabel.text = "Мин: ℃"
            }
            
            if tempMax != nil {
                self.maxDegreeLabel.text =  tempMax! > 0 ? "Макс: +\(tempMax!)℃" : "Макс: \(tempMax!)℃"
            } else {
                self.maxDegreeLabel.text = "Макс: ℃"
            }
            
            // После настройки презентуем себя:
            if let callback = self.callback {
                print("____________CALLBACK")
                callback()
            }
        }
    }
    
    /// Метод проверяет, есть ли погода в словаре Cities. Если нет, то должен запустить getWeather из NetworkService.
    private func fetchWeather(city: String) -> Weather? {
        var cityWeather: Weather?
        if let weatherFromList = cities.listWithWeather[city] {
            cityWeather = weatherFromList
        } else {
            let networkService: NetworkService = NetworkServiceImpl()
            let group = DispatchGroup()
            group.enter()
            networkService.getWeather(for: city) { [weak self] result in
                switch result {
                case .success(let fetchedWeather):
                    cityWeather = fetchedWeather
                case .failure(let error):
                    print(type(of: self), #function, "\(error.localizedDescription)")
                }
                group.leave()
            }
            group.wait()
        }
        
        return cityWeather
    }
    
    private func setConditionDescription(condition: String) -> String {
        switch condition {
        case "clear":
            return "ясно"
        case "partly-cloudy":
            return "малооблачно"
        case "cloudy":
            return "облачно с прояснениями"
        case "overcast":
            return "пасмурно"
        case "drizzle":
            return "морось"
        case "light-rain":
            return "небольшой дождь"
        case "rain":
            return "дождь"
        case "moderate-rain":
            return "умеренно сильный дождь"
        case "heavy-rain":
            return "сильный дождь"
        case "continuous-heavy-rain":
            return "длительный сильный дождь"
        case "showers":
            return "ливень"
        case "wet-snow":
            return "дождь со снегом"
        case "light-snow":
            return "небольшой снег"
        case "snow":
            return "снег"
        case "snow-showers":
            return "снегопад"
        case "hail":
            return "град"
        case "thunderstorm":
            return "гроза"
        case "thunderstorm-with-rain":
            return "дождь с грозой"
        case "thunderstorm-with-hail":
            return "гроза с градом"
        default:
            return ""
        }
    }
    
    private func setWindDescription(wind: String) -> String {
        switch wind {
        case "nw":
            return "С/З"
        case "n":
            return "С"
        case "ne":
            return "С/В"
        case "e":
            return "В"
        case "se":
            return "Ю/В"
        case "s":
            return "Ю"
        case "sw":
            return "С/З"
        case "w":
            return "В"
        default:
            return ""
        }
    }
    
}
