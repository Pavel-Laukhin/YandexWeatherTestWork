//
//  ViewController+DataSource.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let city = cities.list[indexPath.row]
        cell.city = city
        if let weather = cities.listWithWeather[city] {
            cell.weather = weather
        }
        return cell
    }
    
}
