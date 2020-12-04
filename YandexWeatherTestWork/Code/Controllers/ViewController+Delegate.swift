//
//  ViewController+Delegate.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            lastTimeSelectedRowIndexPath = indexPath
            let city = cities.list[indexPath.row]
            let vc = DetailViewController(forCity: city)
            navigationController?.pushViewController(vc, animated: true)
        } else if tableView.indexPathsForSelectedRows != nil {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForSelectedRows == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, complete in

            CitiesImpl.shared.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            complete(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
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
