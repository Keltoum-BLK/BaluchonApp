//
//  ApiWeatherService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 08/10/2021.
//

import Foundation

class ApiWeatherService {
    
    //MARK: Singleton
    static let shared = ApiWeatherService()
    private init() {}
    
    //MARK: Error Manager
    enum APIError: Error {
        case decoding
        case server
        case emptyResponse
    }
    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var weatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession) {
        
        self.weatherSession = weatherSession
    }
   
    //MARK: Methods
    func givingTheWeather(completion: @escaping (Result<PageWeather, APIError>) -> Void) {
        
        let urlLocalizedWeather = "api.openweathermap.org/data/2.5/weather?q=paris&appid=d39aa9247aa0e8e120ee04f68df6ff6b&units=metric&lang=fr"
        guard let urlPercentEscapes = urlLocalizedWeather.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: urlPercentEscapes) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { completion(.failure(.server))
                    print("Houla")
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.emptyResponse))
                    print("OUtch")
                    return
                }
                
                guard let weatherInfo = try? JSONDecoder().decode(PageWeather.self, from: data) else {
                    completion(.failure(.decoding))
                    print("Aie")
                    return
                }
                completion(.success(weatherInfo))
                print("Yeah")
            }
        }
        dataTask?.resume()
    }
            
}
    
    

