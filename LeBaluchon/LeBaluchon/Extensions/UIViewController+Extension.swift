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
    func alertSearchCityIncorrect(city: String){
        if city == "", city.first == ".", city.isEmpty {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Vous devez sairsir une ville.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    //method to detect error in API Call request
    func alertServerAccess(error: String) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    // alert when user wants to use the same language to translate as the first choice
    func alertSameLanguage() {
        let alert = UIAlertController(title: "Une erreur est survenue", message: "Tu ne peux pas traduire dans la même langue.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    //alert when the value is incorrect and has a specific message
    func alertWithValueError(value: String, message : String) {
        let alert = UIAlertController(title: "Une erreur est survenue", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
