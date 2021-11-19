//
//  Weather.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation
//MARK: STRUCT AND PROPERTIES 
struct PageWeather: Decodable {
    
    let sys: Sys?
    let name: String?
    let main: Main?
    let weather: [Weather]?
    
    struct Weather: Decodable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    struct Main: Decodable {
        let temp: Double?

        enum CodingKeys : String, CodingKey {
            case temp
        }
    }
    
    struct Sys: Decodable {
        let country: String?
        let sunrise: Int?
        let sunset: Int?
        
        enum CodingKeys: String, CodingKey {
            case country
            case sunrise
            case sunset
        }
    }
    
  
}




