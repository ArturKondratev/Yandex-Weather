//
//  ListViewCell.swift
//  YandexWeather
//
//  Created by Артур Кондратьев on 18.03.2022.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameCityLable: UILabel!
    @IBOutlet weak var conditionCityLable: UILabel!
    @IBOutlet weak var tempCityLable: UILabel!
    
    func configure(wether: Weather) {
        self.nameCityLable.text = wether.name
        self.conditionCityLable.text = wether.conditionString
        self.tempCityLable.text = wether.temperatureString + " ºC"
    }
}
