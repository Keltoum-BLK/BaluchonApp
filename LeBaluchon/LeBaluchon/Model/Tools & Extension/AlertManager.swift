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
    func alertSearchCityAction(city: String, controller: UIViewController){
        if city == "" {
            let alert = UIAlertController(title: "Oups! un accident", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertWrongName(city: String, controller: UIViewController){
        
            let alert = UIAlertController(title: "Oups! un accident", message: city, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        
    }
    
    func alertTextEmpty(text: String, controller: UIViewController){
        if text == "" {
            let alert = UIAlertController(title: "Oups! un accident", message: "Tu as oublié ce que tu voulais traduire.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
}
