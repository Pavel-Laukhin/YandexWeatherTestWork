//
//  StringProtocol Extension.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 03.12.2020.
//

import Foundation

/// Чтобы только первое слово в строке начиналось с заглавной буквы, а остальные шли со строчной
extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return self as! String }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        guard let first = first else { return self as! String }
        return String(first).capitalized + dropFirst()
    }
}
