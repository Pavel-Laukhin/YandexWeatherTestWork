//
//  ViewController+Delegate.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastTimeSelectedRowIndexPath = indexPath
        let city = cities.list[indexPath.row]
        let vc = DetailViewController(forCity: city)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.text, !city.isEmpty {
            showDetailWeatherFor(city: city)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    /// Ограничим количество символов для сёрч бара. Так, на всякий случай.
    /// Так как в России город с самым длинным названием - это Александровск-Сахалинский, который имеет 25 символов, то пусть и ограничение будет 25 символов. Надеюсь, никто не захочет искать температуру Исландских населенных пунктов и вулканов :]
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        return totalCharacters <= 25
    }
    
}
