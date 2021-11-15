//
//  Constants.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import Foundation
import UIKit


class Constants {
   //MARK: Proporties
    static let shared = Constants()
    private var infoIcon: PageWeather?
    
    let languageArray = ["Anglais","Arabe", "Coréen", "Japonais", "Espagnol","Français", "Portuguais"]
    
    
    //MARK: METHOD FOR SWITCH IN TRANSLATE AND CURRENCY VIEW
    func swapString(string1 : inout String, string2: inout String) {
        (string1, string2) = (string2, string1)
    }
  
    
    
    //MARK: METHODS FOR WEATHER VIEW
    func upDatePic(image: String) -> String {
        if image == "", image != infoIcon?.weather?.first?.icon {
            return "Nopic"
        } else {
            return image
        }
    }
    
    func timeStamp(time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return String(dateString)
    }
    
    
    func createSymbolsList(dictionnary : [String : String]) -> [Currency] {
        var list = [Currency]()
        for (keys, values) in dictionnary {
           let currency = Currency(code: keys, name: values)
            list.append(currency)
        }
        let listArr = list.sorted(by: { $0.name < $1.name})
        return listArr
    }
 
    func createCurrencyList(dictionnary : [String : Double]) -> [CurrencyValue] {
        var list = [CurrencyValue]()
        for (keys, values) in dictionnary {
           let currency = CurrencyValue(code: keys, value: values)
            list.append(currency)
        }
        let listArr = list.sorted(by: { $0.code ?? "NIL" < $1.code ?? "NoCode"})
        return listArr
    }
    
    func getTheChange(start with: String, with currencyvalue: Double) -> String {
        let result = Double(with) ?? 0 * currencyvalue
        let resultStr = String(result)
        return resultStr
    }
}
