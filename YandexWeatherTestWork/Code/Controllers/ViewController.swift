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
        addEditButton()
        
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
    }
    
    // MARK: - Actions
    func showDetailWeatherFor(city: String) {
        if !cities.list.contains(city) {
            ActivityIndicatorViewController.startAnimating(in: self)
        }
        let detailVC = DetailViewController(forCity: city)
        
        // Передадим вью контроллеру задачу по остановке активити индикатора и презентации самого себя поверх всех окон:
        detailVC.callback = { [weak self] (view, weather) in
            guard let self = self else { return }
            
            // Настраиваем навигейшн контроллер, в котором будут две кнопки
            let navigationVC = UINavigationController(rootViewController: detailVC)
            let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(self.hideDetailVC))
            let addButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(self.addSearchedCity))
            detailVC.navigationItem.leftBarButtonItem = cancelButton
            detailVC.navigationItem.rightBarButtonItem = addButton
            ActivityIndicatorViewController.stopAnimating(in: self)
            
            // Устанавлиаваем значок погодных условий
            self.fetchAndSetConditionImage(for: view, from: weather)
            
            // Презентуем то, что получилось
            self.present(navigationVC, animated: true, completion: nil)
        }
    }
    
    @objc private func hideDetailVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addSearchedCity() {
        guard let searchedCity = searchBar.text?.capitalized else { return }
        cities.add(city: searchedCity)
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    @objc private func editMode() {
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: true)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonAction))
        navigationItem.rightBarButtonItem = cancelButton
        addOrRemoveDeleteButton()
    }
    
    @objc private func cancelButtonAction() {
        tableView.setEditing(false, animated: true)
        addEditButton()
        addOrRemoveDeleteButton()
    }
    
    private func addEditButton() {
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editMode))
        navigationItem.rightBarButtonItem = editButton
    }
    
    func addOrRemoveDeleteButton() {
        if navigationItem.leftBarButtonItem == nil {
            let deleteButton = UIBarButtonItem(title: "Удалить", style: .plain, target: self, action: #selector(deleteRows))
            deleteButton.tintColor = .red
            deleteButton.isEnabled = false
            navigationItem.leftBarButtonItem = deleteButton
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc private func deleteRows() {
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        var selectedCities: [String] = []
        for indexPath in selectedRows  {
            selectedCities.append(cities.list[indexPath.row])
        }
        
        for city in selectedCities {
            if let index = cities.list.firstIndex(of: city) {
                cities.removeCity(at: index)
            }
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: selectedRows, with: .automatic)
        tableView.endUpdates()
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    private func fetchAndSetConditionImage(for view: UIView, from weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let conditionIconName = weather.fact.icon
            if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(conditionIconName).svg") {
                let conditionImage = UIView(SVGURL: url) { image in
                    image.resizeToFit(self.view.bounds)
                }
                view.addSubview(conditionImage)
            }
        }
    }

}

