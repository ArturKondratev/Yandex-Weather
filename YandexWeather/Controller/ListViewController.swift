//
//  ListViewController.swift
//  YandexWeather
//
//  Created by Артур Кондратьев on 17.03.2022.
//

import UIKit

class ListViewController: UITableViewController {
    
    let networkWeatherManager = NetworkWeatherManager()
        
    let emptyCity = Weather()
    var citysArray = [Weather]()
    var filterCityArray = [Weather]()
    
    var nameCitys = ["Москва", "Сочи", "Верхоянск", "Хабаровск", "Калининград"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempImageView = UIImageView(image: UIImage(named: "back_weather"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView
        
        if citysArray.isEmpty {
            citysArray = Array(repeating: emptyCity, count: nameCitys.count)
        }
        loadWeather()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func addCity(_ sender: Any) {
        
        alertPlusCity(name: "Город", placeholder: "Название города") { (city) in
            
            if city.isEmpty {return}
            self.nameCitys.append(city)
            self.citysArray.append(self.emptyCity)
            self.loadWeather()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadWeather(){
        
        networkWeatherManager.getCityWeather(cityArray: self.nameCitys) { index, weather in
            self.citysArray[index] = weather
            self.citysArray[index].name = self.nameCitys[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filterCityArray.count
        }
        return citysArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListViewCell
        
        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citysArray[indexPath.row]
        }
        cell.configure(wether: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delateAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            
            let editingRow = self.nameCitys[indexPath.row]
            
            if let index = self.nameCitys.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citysArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delateAction])
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                let destVC = segue.destination as! DetaliVC
                destVC.wetherModel = filter
                
            } else {
                let cityMether = citysArray[indexPath.row]
                let destVC = segue.destination as! DetaliVC
                destVC.wetherModel = cityMether
            }
        }
    }
    
    func alertPlusCity(name: String, placeholder: String, completinHandler: @escaping (String) -> Void) {
        
        let alertController =  UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let allertOK = UIAlertAction(title: "OK", style: .default) { (action) in
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            completinHandler(text)
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in }
        alertController.addAction(allertOK)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchBar(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchBar(_ searchText: String) {
        filterCityArray = citysArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
