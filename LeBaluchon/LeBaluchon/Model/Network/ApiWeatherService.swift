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
    
    //MARK: Properties
    private var dataTask: URLSessionDataTask?
    var weatherSession = URLSession(configuration: .default)
    var weatherController = WeatherController()
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    //MARK: Methods
    func getTheWeather(city: String, completion: @escaping (Result<PageWeather, APIError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: SecretsKeys.apiKeyWeather),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr")]
        
        guard let urlWeather = urlComponents.url?.absoluteString else { return }
        
        guard let url = URL(string: urlWeather) else { return }
        
        dataTask = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { completion(.failure(.server))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.network))
                    return
                }
                
                guard let weatherInfo = try? JSONDecoder().decode(PageWeather.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(weatherInfo))
            }
        }
        dataTask?.resume()
    }
    
    func getLocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<PageWeather, APIError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: SecretsKeys.apiKeyWeather),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr")]
        
        guard let urlWeather = urlComponents.url?.absoluteString else { return }
        
        guard let url = URL(string: urlWeather) else { return }
        
        dataTask = weatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { completion(.failure(.server))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.network))
                    return
                }
                
                guard let weatherInfo = try? JSONDecoder().decode(PageWeather.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                completion(.success(weatherInfo))
            }
        }
        dataTask?.resume()
    }
    
}



