//
//  ApiService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation


class ApiService {
    
    static let shared = ApiService()
    
    let apiKeyWeather = "d39aa9247aa0e8e120ee04f68df6ff6b"
    let apiKeyCurrency = "03479052e9afb24dc5416b800447e4ad"
    let apiKeyTranslate = "AIzaSyCo95wNsNcsUAMC0PIowXUQjEtnSFx5sjk"

  
    func translate(source: String, q: String, target: String){
        let urlTranslate = "https://translation.googleapis.com/language/translate/v2?key=\(apiKeyTranslate)&source=\(source)&target=\(target)&q=\(q)"
    }
    
    func givingTheWeather(source: String, q: String, target: String){
        let weatherSettings = "&units=metric&lang=fr"
        var urlLocalizedWeather = "api.openweathermap.org/data/2.5/weather?q=\(q)&appid=\(apiKeyWeather)" + weatherSettings
    }
    
    func getTheChange(currency1: String, countToChange: Double, currency2: String, countToGet: Double) {
        
    }
}
