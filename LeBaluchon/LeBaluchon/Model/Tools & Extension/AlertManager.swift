//
//  AlertManager.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 13/11/2021.
//

import Foundation
import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    //MARK: Alert methods
    func alertAddCity(city: String, controller: UIViewController){
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
    
    func alertGiveElementToTranslate(text: String, controller: UIViewController){
        if text == "" {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu as oublié ce que tu voulais traduire.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func AlertEmptyChoiceLanguage(error: String, controller: UIViewController) {
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
