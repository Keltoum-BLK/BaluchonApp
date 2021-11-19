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
    //properties Units Test
    var resultStr = ""
    var listValue = [CurrencyValue]()
    var list = [Currency]()
    var dictionnary = ["FR" : "Français"]
    var dictionnaryValues = ["FR" : 1.5]
    
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
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = formatter.string(from: date)
        return String(dateString)
    }
    
    //MARK: METHODS FOR CURRENCY VIEW
    func createSymbolsList(dictionnary : [String : String]) -> [Currency] {
        
        for (keys, values) in dictionnary {
           let currency = Currency(code: keys, name: values)
            list.append(currency)
        }
        let listArr = list.sorted(by: { $0.name < $1.name})
        return listArr
    }
 
    func createCurrencyList(dictionnary : [String : Double]) -> [CurrencyValue] {
        for (keys, values) in dictionnary {
           let currency = CurrencyValue(code: keys, value: values)
            listValue.append(currency)
        }
        let listArr = listValue.sorted(by: { $0.code ?? "NIL" < $1.code ?? "NoCode"})
        return listArr
    }
    
    func getTheChange(amount: String, with currencyvalue: Double, controller: UIViewController) -> String {
        if amount == "0" || amount.first == "." || amount.first == " " {
            AlertManager.shared.alertGiveAmount(amount: amount, controller: controller)
            return "Error"
        } else {
            let doubleStr = Double(amount)
            guard let multiply = doubleStr else { return "no info"}
            var result = currencyvalue * multiply
            result = round(result * 100) / 100
            resultStr = String(result)
            return resultStr
        }
    }
}
