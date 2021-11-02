//
//  Weather.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation

struct PageWeather: Decodable {
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Temperature: Decodable {
        let temp: Double
        let tempFeels: Double
        let tempMin: Double
        let tempMax: Double
       
        
        enum CodingKeys : String, CodingKey {
            case temp
            case tempFeels = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Country : Decodable {
        let idCountry: Int
        let country: String
        let sunrise: Int
        let sunset: Int
        
        enum CodingKeys: String, CodingKey {
            case idCountry = "id"
            case country
            case sunrise
            case sunset
        }
    }
        struct City: Decodable {
            let idCity: Int
            let name: String
        
            enum CodingKeys: String, CodingKey {
                case idCity = "id"
                case name
            }
        }
    let country: Country
    let sunriseCountry: Country
    let sunsetCountry: Country
    let city: City
    let temp : Temperature
    let feelsLike : Temperature
    let tempMin: Temperature
    let tempMax: Temperature
    let weather: [Weather]
    let weatherDesc: [Weather]
}




