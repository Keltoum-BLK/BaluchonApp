//
//  Constants.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import Foundation


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
}
