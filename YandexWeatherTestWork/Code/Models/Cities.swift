//
//  Cities.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import Foundation

protocol Cities {
    
    var list: [String] { get }
    var listWithWeather: [String: Weather] { get }
    var count: Int { get }
    mutating func add(city: String)
    mutating func removeCity(at index: Int)
    mutating func addWeatherFor(city: String, weather: Weather)
    
}

final class CitiesImpl: Cities {
    
    static var shared: Cities = CitiesImpl()
    
    var list: [String] { return arrayOfCities }
    var listWithWeather: [String: Weather] { return  dictionaryOfCitiesWithWeather }
    var count: Int { return arrayOfCities.count }
    
    private var arrayOfCities: [String] = [
        "Москва",
        "Санкт-Петербург",
        "Самара",
        "Уфа",
        
        "Казань",
        "Екатеринбург",
        "Новосибирск",
        "Иркутск",
        
        "Владивосток",
        "Сочи"
    ]
    
    private var dictionaryOfCitiesWithWeather: [String: Weather] = [:]
    
    private init() {}
    
    func add(city: String) {
        arrayOfCities.append(city)
    }
    
    
    func removeCity(at index: Int) {
        arrayOfCities.remove(at: index)
    }
    
    func addWeatherFor(city: String, weather: Weather) {
        dictionaryOfCitiesWithWeather[city] = weather
    }
        
}

/// Защита от случайного клонирования
extension CitiesImpl: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
