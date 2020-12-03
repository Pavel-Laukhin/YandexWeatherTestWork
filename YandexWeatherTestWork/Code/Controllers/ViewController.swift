//
//  ViewController.swift
//  YandexWeatherTestWork
//
//  Created by Павел on 01.12.2020.
//

import UIKit

final class ViewController: UIViewController {
    
    var cities = CitiesImpl.shared
    var lastTimeSelectedRowIndexPath: IndexPath?
    let queue = OperationQueue()
    
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
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Делаем так, чтобы строка гасла после появления вью контроллера на экране:
        if let indexPath = lastTimeSelectedRowIndexPath {
            tableView.deselectRow(at: indexPath, animated: true)
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
        ActivityIndicatorViewController.startAnimating(in: self)
        let detailVC = DetailViewController(forCity: city)
        
        // Передадим вью контроллеру задачу по остановке активити индикатора и презентации самого себя поверх всех окон:
        detailVC.callback = { [weak self] in
            guard let self = self else { return }
            let navigationVC = UINavigationController(rootViewController: detailVC)
            let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(self.hideDetailVC))
            let addButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(self.hideDetailVC))
            detailVC.navigationItem.leftBarButtonItem = cancelButton
            detailVC.navigationItem.rightBarButtonItem = addButton
            ActivityIndicatorViewController.stopAnimating(in: self)
            self.present(navigationVC, animated: true, completion: nil)
        }
    }
    
    @objc private func hideDetailVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func editMode() {
        tableView.setEditing(true, animated: true)
    }
    
    func updateUI() {
        let networkService: NetworkService = NetworkServiceImpl()
        cities.list.forEach { [weak self] city in
            guard let self = self else { return }
            networkService.getWeather(for: city) { result in
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.cities.addWeatherFor(city: city, weather: weather)
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(type(of: self), #function, error.localizedDescription)
                }
            }
        }
        
        // MARK: когда нужен всего 1 город
//        if let firstCity = cities.list.first {
//            networkService.getWeather(for: firstCity) { result in
//                switch result {
//                case .success(let weather):
//                    DispatchQueue.main.async {
//                        self.cities.addWeatherFor(city: firstCity, weather: weather)
//                        self.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    print(type(of: self), #function, error.localizedDescription)
//                }
//            }
//        }
    }

}

