//
//  NetworkWeatherManager.swift
//  YandexWeather
//
//  Created by Артур Кондратьев on 17.03.2022.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    let apiKey = "f7151b9f-0d5b-4083-8c4b-e6b330dcf191"
  
    func getCityWeather(cityArray: [String], complitionHandler: @escaping (Int, Weather) -> Void) {
        
        for (index, item) in cityArray.enumerated() {
            
            getCoordinateFrom(city: item) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                self.fetchweather(latitude: coordinate.latitude, longtitude: coordinate.longitude) { (Weather) in
                    
                    complitionHandler(index, Weather)
                }
            }
        }
    }
    
    func getCoordinateFrom (city: String, complition: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            complition(placemark?.first?.location?.coordinate, error)
        }
    }
    
    func fetchweather(latitude: Double, longtitude: Double, completionHandler: @escaping (Weather) -> Void ) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longtitude)"
        guard let url =  URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data else {
                return
            }
            if let weather = self.parseJSON(withData: data) {
                print(weather)
                completionHandler(weather)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let wetherData = try decoder.decode(WeatherData.self, from: data)
            guard let wether = Weather(weatherData: wetherData) else {
                return nil
            }
            return wether
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
