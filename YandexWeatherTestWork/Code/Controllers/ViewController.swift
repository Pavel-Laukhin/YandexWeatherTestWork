//
//  ViewController.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.placeholder = "Найти город..."
        return bar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: String(describing: TableViewCell.self))
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Яндекс.Погода"
        addSubviews()
        setupLayout()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMode))
        navigationItem.rightBarButtonItem = editButton
        
        DispatchQueue.global().async {
            let networkService: NetworkService = NetworkServiceImpl()
            networkService.getWeather(for: "Москва")
        }
    }
    
    private func addSubviews() {
        [tableView,
        searchBar].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        [tableView,
         searchBar].forEach { $0.toAutoLayout() }
            
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showDetailWeatherFor(city: String) {
        let detailVC = DetailViewController(for: City(cityName: "New York", degree: 11))
        let navigationVC = UINavigationController(rootViewController: detailVC)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(hideDetailVC))
        let addButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(hideDetailVC))
        detailVC.navigationItem.leftBarButtonItem = cancelButton
        detailVC.navigationItem.rightBarButtonItem = addButton
        present(navigationVC, animated: true, completion: nil)
    }
    
    @objc private func hideDetailVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func editMode() {
        tableView.setEditing(true, animated: true)
    }

}

