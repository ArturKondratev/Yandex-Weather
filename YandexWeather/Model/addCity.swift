////
////  addCity.swift
////  YandexWeather
////
////  Created by Артур Кондратьев on 18.03.2022.
////
//
//import Foundation
//import UIKit
//
//extension UIViewController {
//
//    func alertPlusCity(name: String, placeholder: String, completinHandler: @escaping (String) -> Void) {
//
//        let alertController =  UIAlertController(title: name, message: nil, preferredStyle: .alert)
//        let allertOK = UIAlertAction(title: "OK", style: .default) { (action) in
//
//            let tftext = alertController.textFields?.first
//            guard let text = tftext?.text else { return }
//            completinHandler(text)
//        }
//
//        alertController.addTextField { (tf) in
//            tf.placeholder = placeholder
//        }
//        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in }
//
//        alertController.addAction(allertOK)
//        alertController.addAction(alertCancel)
//
//        present(alertController, animated: true, completion: nil)
//    }
//}
//
