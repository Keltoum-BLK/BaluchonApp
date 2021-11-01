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
    }
    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var weatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession) {
        
        self.weatherSession = weatherSession
    }
   
    //MARK: Methods
    func givingTheWeather(city: String, completion: @escaping (Result<PageWeather, APIError>) -> Void) {
        
        let weatherSettings = "&units=metric&lang=fr"
        var urlLocalizedWeather = "api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(SecretsKeys.apiKeyWeather)" + weatherSettings
        
        guard let url = URL(string: urlLocalizedWeather) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            guard error == nil else { completion(.failure(.server))
                return
            }
            
        }
    }
    
}
