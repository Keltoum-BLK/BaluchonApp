//
//  ApiService.swift
//  LeBaluchon
//
//  Created by Kel_Jellysh on 04/10/2021.
//

import Foundation


class ApiCurrencyService {
    
    static let shared = ApiCurrencyService()
    
   
  
    
    func getTheCurrency() -> String {
        let listOfCurrenciesUrl = "http://data.fixer.io/api/symbols?access_key=\(apiKeyCurrency)"
        
        return "DZD"
    }
    
    func getTheGoodChange(){
        
    }
    
    func getTheChange(currency1: String, countToChange: Double, currency2: String, countToGet: Double) {
        
    }

}
