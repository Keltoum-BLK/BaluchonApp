//
//  Constants.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 11/10/2021.
//

import Foundation
import UIKit


class Tools {
   //MARK: Proporties
    static let shared = Tools()
    
    //MARK: METHOD
    func getTheChange(amount: String, with currencyvalue: Double, controller: UIViewController) -> String {
        if amount == "0" || amount.first == "." || amount.first == " " {
            alertGiveAmount(amount: amount, controller: controller)
            return "Error"
        } else {
            let doubleStr = Double(amount)
            guard let multiply = doubleStr else { return "no info"}
            var result = currencyvalue * multiply
            result = round(result * 100) / 100
            let resultStr = String(result)
            return resultStr
        }
    }
    
    //MARK: Alert methods
    func alertSearchCity(city: String, controller: UIViewController){
        if city == "", city.first == "." {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertServerAccess(city: String, controller: UIViewController){
        let alert = UIAlertController(title: "Une erreur est survenue", message: city, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertGetElementToTranslate(text: String, controller: UIViewController){
        if text == "" {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu as oublié ce que tu voulais traduire.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func AlertSelectLanguages(error: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Sélectionnes les langues pour réaliser la traduction.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertSameLanguage(controller: UIViewController) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu ne peux pas traduire dans la même langue.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertGiveAmount(amount: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu as oublié le montant ou la devise.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
    
    
}
