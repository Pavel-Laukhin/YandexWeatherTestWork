//
//  SceneDelegate.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Создаем сцену:
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Присваиваем значение нашей опциональной переменной window, создав экземпляр главного экрана, главного окна. Передадим в него координатное пространство ранее созданной сцены, которую использует SwiftUI:
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // Создаем приложение с навигейшн контроллером:
        let navigationController = UINavigationController(rootViewController: ViewController())
        
        // Ставим нашему окну корневой контроллер и активизируем окно:
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

