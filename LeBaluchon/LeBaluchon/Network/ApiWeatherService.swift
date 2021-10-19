//
//  ApiWeatherService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 08/10/2021.
//

import Foundation

class ApiWeatherService {
    private var dataTask: URLSessionDataTask?
    static let shared = ApiWeatherService()
    
    let apiKeyWeather = "d39aa9247aa0e8e120ee04f68df6ff6b"
    
    
    func givingTheWeather(source: String, q: String, target: String){
        let weatherSettings = "&units=metric&lang=fr"
        var urlLocalizedWeather = "api.openweathermap.org/data/2.5/weather?q=\(q)&appid=\(apiKeyWeather)" + weatherSettings
        
        guard let url = URL(string: urlLocalizedWeather) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
    
        }
    }
    
}
