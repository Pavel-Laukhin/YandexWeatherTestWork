//
//  ViewController+Delegate.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = Cities.list[indexPath.row]
        let vc = DetailViewController(for: city)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
