//
//  NetworkService.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import Foundation
import CoreLocation

protocol NetworkService {
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void)
    
}

struct NetworkServiceImpl: NetworkService {
    
    private let scheme = "https"
    private let host = "api.weather.yandex.ru"
    private let path = "/v2/forecast"
    private let headerForKey = "X-Yandex-API-Key"
    private let apiKey = Constants.xYandexAPIKey
    
    private let sharedSession = URLSession.shared
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let request = getWeatherRequest(for: city) else { return }
        
        let dataTask = sharedSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data received")
                completion(.failure(URLError(.dataNotAllowed)))
                return
            }
            
            let decoder = JSONDecoder()
            if let weather = try? decoder.decode(Weather.self, from: data)   {
                completion(.success(weather))
//                // Работаем с полученной погодой
//                print("weather.fact.temp")
//                print(weather.fact.temp)
//                print("weather.fact.condition")
//                print(weather.fact.condition)
//                print("weather.forecasts.first?.parts.day.tempMax")
//                print(weather.forecasts.first?.parts.day.tempMax)
//                print("weather.forecasts.first?.parts.evening.tempMin")
//                print(weather.forecasts.first?.parts.evening.tempMin)

            }
        }
        
        dataTask.resume()
    }
    
    private func getWeatherRequest(for city: String) -> URLRequest? {
        var locationCoordinate: CLLocationCoordinate2D?
        let group = DispatchGroup()
        group.enter()
        getCoordinatesOfCity(city) { result in
            switch result {
            case .success(let coordinate):
                locationCoordinate = coordinate
            case .failure(let error):
                print(type(of: self), #function, "\(error.localizedDescription)")
            }
            group.leave()
        }
        
        group.wait()
        guard let coordinate = locationCoordinate else { return nil }
        let urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
                URLQueryItem(name: "lon", value: "\(coordinate.longitude)")]
            return urlComponents
        }()
        
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = [headerForKey: apiKey]
        return urlRequest
    }
    
    func getCoordinatesOfCity(_ city: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let coordinates = placemarks?.first?.location?.coordinate {
                completion(.success(coordinates))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
}
