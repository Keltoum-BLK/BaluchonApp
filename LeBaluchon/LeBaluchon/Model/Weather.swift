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
    
    //MARK: METHODS FOR WEATHER VIEW
    func upDatePic(image: String) -> String {
        if image == "", image != self.weather?.first?.icon {
            return "Nopic"
        } else {
            return image
        }
    }
    
    func timeStamp(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return String(dateString)
    }
  
}




