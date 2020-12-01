//
//  Cities.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import Foundation

struct Cities {
    
    static var list: [City] = [
        City(cityName: "Москва", degree: 0),
        City(cityName: "Санкт-Петербург", degree: -5),
        City(cityName: "Самара", degree: -10),
        City(cityName: "Уфа", degree: 1),
        
        City(cityName: "Казань", degree: -2),
        City(cityName: "Екатеринбург", degree: -5),
        City(cityName: "Новосибирск", degree: -10),
        City(cityName: "Иркутск", degree: -15),
        
        City(cityName: "Владивосток", degree: 0),
        City(cityName: "Сочи", degree: 15),
    ]
    
}
