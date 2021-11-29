//
//  UIViewController+Extension.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 29/11/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: Alert methods
    func alertSearchCity(city: String){
        if city == "", city.first == "." {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertServerAccess(city: String){
        let alert = UIAlertController(title: "Une erreur est survenue", message: city, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertGetElementToTranslate(text: String){
        if text == "" {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu as oublié ce que tu voulais traduire.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func AlertSelectLanguages(error: String) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertSameLanguage() {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu ne peux pas traduire dans la même langue.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertWithValueError(value: String) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu as oublié le montant ou la devise.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
