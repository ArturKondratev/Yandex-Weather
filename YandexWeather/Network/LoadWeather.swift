////
////  LoadWeather.swift
////  YandexWeather
////
////  Created by Артур Кондратьев on 17.03.2022.
////
//
//import Foundation
//
//enum FriendsError: Error {
//    case parseError
//    case requestError(Error)
//}
//
//
//
//class LoadWeather {
//
//    func loadFriend(completion: @escaping ((Result<Weatherdata, FriendsError>) -> ())) {
//        let token = Session.instance.apiKey
//
//        let params: [String: String] = ["v": "5.81",
//                                        "access_token": token,
//                                        "fields": "photo_50"
//        ]
//
//        let url = configureUrl(token: token,
//                               method: .friendsGet,
//                               htttpMethod: .get,
//                               params: params)
//        print(url)
//
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                return completion(.failure(.requestError(error)))
//            }
//
//            guard let data = data else { return }
//            let decoder = JSONDecoder()
//
//            do {
//                let result = try decoder.decode(FriendsVK.self, from: data)
//
//                print(result)
//                return completion(.success(result))
//            } catch {
//                return completion(.failure(.parseError))
//            }
//        }
//        task.resume()
//    }
//}
