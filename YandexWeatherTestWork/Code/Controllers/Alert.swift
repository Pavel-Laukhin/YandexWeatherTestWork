//
//  ViewController.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 03.12.2020.
//

import UIKit

final class Alert {
    
    /** Создает базовый алерт
    - parameters:
        - vc: Контроллер, который будет отображать алерт
     */
    class func showBasic(vc: UIViewController) {
        let alert = UIAlertController(title: "Неизвестная ошибка!", message: "Что-то пошло не так. Попробуйте повторить попытку позднее.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    /// Создает алерт о том, что город не найден
    class func showUknownLocation() {
        DispatchQueue.main.async {
            guard let navigationController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? UINavigationController else { return }

                let alert = UIAlertController(title: "Населенный пункт не найден!", message: "К сожалению, мы не знаем, где находится место, которое вы ищете. Попробуйте поискать что-то другое.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                navigationController.present(alert, animated: true)
        }
    }
    
}
