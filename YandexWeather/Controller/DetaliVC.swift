//
//  DetaliVC.swift
//  YandexWeather
//
//  Created by Артур Кондратьев on 18.03.2022.
//

import UIKit
import SwiftSVG

class DetaliVC: UIViewController {
    
    @IBOutlet weak var nameCityLable: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLable: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var mintempLabel: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var maxT: UILabel!
    @IBOutlet weak var minT: UILabel!
    
    var wetherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        refreshLabels()
    }
    
    func refreshLabels() {
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(wetherModel!.conditionCode).svg")
        
        let weatherImage = UIView(SVGURL: url!) { (image) in
            image.resizeToFit(self.viewCity.bounds)
        }
        self.viewCity.addSubview(weatherImage)
        
        nameCityLable.text = wetherModel?.name
        conditionLable.text = wetherModel?.conditionString
        tempCity.text = "\((wetherModel?.temperatureString)!) ºC "
        feelsLikeTemp.text = "\((wetherModel?.feelslikeString)!) ºC "
        pressureLabel.text = "\((wetherModel?.pressureMm)!)" + " мм рт.ст."
        windSpeedLabel.text = "\((wetherModel?.windSpeed)!)" + " м/с"
        maxTempLabel.text = "\((wetherModel?.tempMax)!)" + " ºC"
        mintempLabel.text = "\((wetherModel?.tempMin)!)" + " ºC"
    }
    
    func setColor() {
        nameCityLable.textColor = UIColor.white
        tempCity.textColor = UIColor.white
        conditionLable.textColor = UIColor.white
        tempCity.textColor = UIColor.white
        feelsLike.textColor = UIColor.white
        feelsLikeTemp.textColor = UIColor.white
        pressureLabel.textColor = UIColor.white
        pressure.textColor = UIColor.white
        windSpeedLabel.textColor = UIColor.white
        windSpeed.textColor = UIColor.white
        maxTempLabel.textColor = UIColor.white
        maxT.textColor = UIColor.white
        mintempLabel.textColor = UIColor.white
        minT.textColor = UIColor.white
    }
}
