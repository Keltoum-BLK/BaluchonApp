//
//  Constants.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import Foundation
import UIKit


class Constants {
   
    static let shared = Constants()
    private var infoIcon: PageWeather?
    
    let languageArray = ["Anglais","Arabe", "Coréen", "Japonais", "Espagnol","Français", "Portuguais"]
    
    func swapString(string1 : inout String, string2: inout String) {
        (string1, string2) = (string2, string1)
    }
    
    func upDatePic(image: String) -> String {
        if image == "", image != infoIcon?.weather?[0].icon {
            return "Nopic"
        } else {
            return image
        }
    }
    
    func timeStamp(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return String(dateString)
    }
    
    func alertSearchCityAction(city: String, controller: UIViewController){
        if city == "" {
            let alert = UIAlertController(title: "Oups! un accident", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertWrongName(city: String, controller: UIViewController){
        if city == "" {
            let alert = UIAlertController(title: "Oups! un accident", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}